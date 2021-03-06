require 'find'
require 'tmdb3'

class MovieBusiness < ApplicationBusiness

  def scan(directory = nil)
    directory ||= Takeout::Application.config.movies_dir

    tmdb = Tmdb3Service.new
    tmdb.configuration

    Find.find(directory) do |path|
      if path =~ /(.mkv)$/
        ext = $1
        basename = File.basename(path, ext)
        dirname = File.dirname(path)
        #puts "#{dirname} -> [#{basename}]"

        if basename =~ /^(.+)\s+\((\d+)\)$/
          title = $1
          year = $2
          edition = nil
          part = nil
          parts = nil
        elsif basename =~ /^(.+)\s+\((\d+)\)\s+\((\d+) of (\d+)\)$/
          title = $1
          year = $2
          edition = nil
          part = $3
          parts = $4
        elsif basename =~ /^(.+)\s+\((\d+)\)\s+\[(.+)\]$/
          title = $1
          year = $2
          edition = $3
          part = nil
          parts = nil
        elsif basename =~ /^(.+)\s+(\d+)$/
          title = $1
          year = $2
          edition = nil
          part = nil
          parts = nil
        else
          title = basename
          year = nil
          edition = nil
          part = nil
          parts = nil
        end

        next unless File.exists?(path)
        file = File.new(path)

        movie = Movie.find_by_file_uri(path)
        next if movie

        puts "#{path} | #{title} | #{year}"

        results = tmdb.movie_search(title, year)
        results = tmdb.movie_search(title.gsub(/\s+-\s+/, ' '), year) if results.empty?
        results = tmdb.movie_search(title.gsub(/\s+-\s+/, ' ').gsub(/-/, ''), year) if results.empty?
        results = tmdb.movie_search(title.gsub(/\s+-\s+/, ' ').gsub(/-/, ' '), year) if results.empty?

        unless results.empty?
          result = results.first
          result = tmdb.movie_detail(result['id'])

          movie = Movie.create(:file_uri => path) unless movie
          movie.imdb_id = result['imdb_id']
          movie.last_modified = file.mtime
          movie.overview = result['overview']
          movie.rating = tmdb.movie_rating(result['id'])
          movie.release_date = result['release_date']
          movie.runtime = result['runtime']
          movie.sort_title = to_sort_title(result['title'])
          movie.tagline = result['tagline']
          movie.title = result['title']
          movie.original_title = result['original_title']
          movie.tmdb_id = result['id']
          movie.save!

          movie.movie_genres.delete_all
          result['genres'].each do |genre|
            movie_genre = MovieGenre.find_or_create_by_name(genre['name'])
            movie_genre.movies << movie
          end

          if result['belongs_to_collection']
            collection = result['belongs_to_collection']
            movie_collection = MovieCollection.find_by_name(collection['name'])
            unless movie_collection
              movie_collection = MovieCollection.create(
                  :name => collection['name'],
                  :sort_name => to_sort_title(collection['name']))
            end
            movie_collection.movies << movie

            collection_images = tmdb.collection_images(collection['id'])
            movie_collection.movie_images.transaction do
              movie_collection.movie_images.destroy_all
              collection_images.each do |image|
                movie_collection.movie_images.create(
                    :source => 'tmdb',
                    :aspect_ratio => image['aspect_ratio'],
                    :language => image['language'],
                    :sort_order => image['sort_order'],
                    :size => image['size'],
                    :image_type => image['type'],
                    :url => image['url'])
              end
            end
          end

          images = tmdb.movie_images(result['id'])

          movie.movie_images.transaction do
            movie.movie_images.destroy_all
            images.each do |image|
              movie.movie_images.create(
                  :source => 'tmdb',
                  :aspect_ratio => image['aspect_ratio'],
                  :language => image['language'],
                  :sort_order => image['sort_order'],
                  :size => image['size'],
                  :image_type => image['type'],
                  :url => image['url'])
            end
          end

          credits = tmdb.movie_credits(result['id'])

          movie.movie_credits.transaction do
            movie.movie_credits.destroy_all
            credits['cast'].each do |cast|
              credit = movie.movie_credits.create(
                  :character => cast['character'],
                  :job => 'Actor',
                  :sort_order => cast['order'])
              member = MovieMember.find_or_create_by_tmdb_id(cast['id'])
              member.name = cast['name']
              member.sort_name = to_sort_name(cast['name'])
              member.save!
              member.movie_credits << credit
              cast['images'].each do |image|
                member.movie_images.create(
                    :size => image['size'],
                    :image_type => image['type'],
                    :url => image['url']
                )
              end if cast['images'] and member.movie_images.empty?
            end if credits['cast']
            credits['crew'].each do |crew|
              credit = movie.movie_credits.create(
                  :department => crew['department'],
                  :job => crew['job'],
                  :sort_order => crew['order'])
              member = MovieMember.find_or_create_by_tmdb_id(crew['id'])
              member.name = crew['name']
              member.sort_name = to_sort_name(crew['name'])
              member.save!
              member.movie_credits << credit
              crew['images'].each do |image|
                member.movie_images.create(
                    :size => image['size'],
                    :image_type => image['type'],
                    :url => image['url']
                )
              end if crew['images'] and member.movie_images.empty?
            end if credits['crew']
          end

        end
      end
    end

    # check for orphans
    Movie.all.each do |movie|
      unless File.exists? movie.file_uri
        puts "no exist #{movie.file_uri}"
        p movie
        movie.destroy
      end
    end

    # TODO remove empty collections
    # TODO remove empty genres

  end
end

o = MovieBusiness.new
o.scan('/data/Video/Movies')
