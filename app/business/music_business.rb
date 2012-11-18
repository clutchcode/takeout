require 'find'
require 'mp3info'
require 'uri_cache'

class MusicBusiness < ApplicationBusiness

  def scan(directory)
    fanart = FanartService.new
    lastfm = Lastfm2Service.new

    Find.find(directory) do |path|
      if path =~ /\.mp3$/
        song = MusicSong.find_or_create_by_file_uri(path)
        next if song and song.last_modified.to_i == File.mtime(path).to_i

        Mp3Info.open(path) do |mp3info|
          music_brainz_tags = {}
          mp3info.tag2.TXXX.each do |tag|
            name, value = tag.split(/[^\w\s_-]+/, 2)
            music_brainz_tags[name] = value
          end if mp3info.tag2.TXXX

          puts "scanning #{path}"

          MusicSong.transaction do
            song = MusicSong.find_or_create_by_file_uri(path)
            song.last_modified = File.mtime(path)
            song.title = mp3info.tag.title
            song.track = mp3info.tag.tracknum
            song.length = mp3info.length
            song.vbr = mp3info.vbr
            song.bitrate = mp3info.bitrate
            song.sample_rate = mp3info.samplerate
            song.channel_mode = mp3info.channel_mode
            song.has_cover = mp3info.tag2.APIC != nil
            tpos = mp3info.tag2.TPOS
            if tpos and tpos =~ /(\d+)\/(\d+)/
              song.part = $1
              song.set = $2
            else
              song.part = 1
              song.set = 1
            end
            song.year = mp3info.tag.year
            song.save!

            song.music_genres.delete_all
            if mp3info.tag.genre_s
              mp3info.tag.genre_s.split(%r{,\s*}).each do |genre|
                music_genre = MusicGenre.find_or_create_by_name(genre)
                music_genre.music_songs << song
              end
            end

            album = MusicAlbum.find_or_create_by_title(mp3info.tag.album)
            album.sort_title = to_sort_title(album.title)
            album.year = mp3info.tag.year
            album.asin = music_brainz_tags['ASIN']
            album.mbid = music_brainz_tags['MusicBrainz Album Id']
            album.original_date = Date.civil(mp3info.tag2.TORY.to_i) if mp3info.tag2.TORY
            album.release_country = music_brainz_tags['MusicBrainz Album Release Country']
            if mp3info.tag2.TDAT
              album.release_date = Date.civil(mp3info.tag2.TYER.to_i,
                                              mp3info.tag2.TDAT[2, 2].to_i,
                                              mp3info.tag2.TDAT[0, 2].to_i)
            else
              album.release_date = Date.civil(mp3info.tag2.TYER.to_i)
            end
            album.release_status = music_brainz_tags['MusicBrainz Album Status']
            album.release_type = music_brainz_tags['MusicBrainz Album Type']
            album.music_songs << song
            album.save!

            artist_name = mp3info.tag2.TPE2 || mp3info.tag2.TPE1 || mp3info.tag.artist
            sort_name = music_brainz_tags['ALBUMARTISTSORT'] || to_sort_title(artist_name)

            artist = MusicArtist.find_or_create_by_name(artist_name)
            artist.mbid = music_brainz_tags['MusicBrainz Album Artist Id']
            artist.sort_name = sort_name.downcase
            artist.save!
            artist.music_albums << album

            fanart_images = artist.music_images.where(:source => 'fanart')
            if fanart_images.empty?
              images = fanart.artist_backdrops(artist.mbid) if artist.mbid
              images.each_value do |v|
                v.each do |key, value|
                  artist.music_images.where(:source => 'fanart', :image_type => 'backdrop').destroy_all
                  if key == "artistbackground"
                    value.each do |image|
                      artist.music_images.create(
                          :source => 'fanart',
                          :image_type => 'backdrop',
                          :url => image['url'],
                          :sort_order => image['likes'])
                    end
                  end
                end
              end if images
            end

            lastfm_images = artist.music_images.where(:source => 'lastfm')
            if lastfm_images.empty?
              artist_info = artist.mbid ? lastfm.artist_info(:mbid => artist.mbid) :
                  lastfm.artist_info(:artist => artist.name)
              band_members = artist_info['artist'] ? artist_info['artist']['bandmembers'] : nil
              p band_members
              images = artist_info['artist'] ? artist_info['artist']['image'] : nil
              if images
                artist.music_images.where(:source => 'lastfm').destroy_all
                images.each do |image|
                  artist.music_images.create(
                      :source => 'lastfm',
                      :image_type => 'image',
                      :size => image['size'],
                      :url => image['#text'])
                end
              end
            end

            #if album.music_credits.empty?
            #  album_info = artist.mbid ? lastfm.album_info(:mbid => album.mbid) :
            #      lastfm.album_info(:artist => artist.name, :album => album.name)
            #  p album_info
            #end


          end
        end
      end
    end
  end

end

o = MusicBusiness.new
#o.scan('/data/Music/Godspeed You! Black Emperor')
#o.scan('/data/Music/Godspeed You Black Emperor!')
o.scan('/data/Music')


