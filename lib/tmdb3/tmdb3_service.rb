class Tmdb3Service
  HOST = 'api.themoviedb.org'
  PORT = 80

  attr_accessor :language
  attr_accessor :country

  def initialize
    @engine = ApiEngine.new('tmdb3', HOST, PORT)
    @engine.json = true
    @api_key = ApiKey.get_key('tmdb3')

    @language = 'en' # ISO 639-1
    @country = 'US' # ISO 3166-1
  end

  def configuration
    @config = invoke('/configuration')
    @config
  end

  def populate(result)
    result['images'] = []

    @config['images']['poster_sizes'].each do |size|
      result['images'] << {
          'size' => size,
          'type' => 'poster',
          'url' => "#{@config['images']['base_url']}#{size}#{result['poster_path']}"
      }
    end if result['poster_path']

    @config['images']['backdrop_sizes'].each do |size|
      result['images'] << {
          'size' => size,
          'type' => 'backdrop',
          'url' => "#{@config['images']['base_url']}#{size}#{result['poster_path']}"
      }
    end if result['poster_path']
  end

  def add_backdrop(images, image)
    @config['images']['backdrop_sizes'].each do |size|
      images << {
          'size' => size,
          'type' => 'backdrop',
          'aspect_ratio' => image['aspect_ratio'],
          'language' => image['iso_639_1'],
          'sort_order' => image['vote_count'],
          'url' => "#{@config['images']['base_url']}#{size}#{image['file_path']}"
      }
    end if image['file_path']
  end


  def add_poster(images, image)
    @config['images']['poster_sizes'].each do |size|
      images << {
          'size' => size,
          'type' => 'poster',
          'aspect_ratio' => image['aspect_ratio'],
          'language' => image['iso_639_1'],
          'sort_order' => image['vote_count'],
          'url' => "#{@config['images']['base_url']}#{size}#{image['file_path']}"
      }
    end if image['file_path']
  end

  def add_profile(images, image)
    @config['images']['profile_sizes'].each do |size|
      images << {
          'size' => size,
          'type' => 'profile',
          'url' => "#{@config['images']['base_url']}#{size}#{image['profile_path']}"
      }
    end if image['profile_path']
  end

  def movie_search(query, year = nil)
    params = { 'query' => query, 'language' => @language }
    params['year'] = year if year
    results = invoke("/search/movie", params)
    results = results['results']
    results.each do |result|
      populate(result)
    end if @config
    results
  end

  def movie_detail(id)
    detail = invoke("/movie/#{id}", 'language' => @language)
    populate(detail) if @config
    detail
  end

  def movie_credits(id)
    credits = invoke("/movie/#{id}/casts")

    credits['cast'].each do |cast|
      if cast['profile_path']
        cast['images'] = []
        add_profile(cast['images'], cast)
      end
    end
    credits['crew'].each do |crew|
      if crew['profile_path']
        crew['images'] = []
        add_profile(crew['images'], crew)
      end
    end
    credits
  end

  def movie_releases(id)
    releases = invoke("/movie/#{id}/releases")
  end

  def movie_rating(id)
    releases = movie_releases(id)
    releases['countries'].each do |release|
      return release['certification'] if release['iso_3166_1'] == @country
    end
    nil
  end

  def movie_images(id)
    result = []
    images = invoke("/movie/#{id}/images", 'language' => @language)
    images ||= {}
    images['backdrops'] ||= []
    images['posters'] ||= []

    if images['backdrops'].empty? or images['posters'].empty?
      all_images = invoke("/movie/#{id}/images")
      all_images ||= {}
      all_images['backdrops'] ||= []
      all_images['posters'] ||= []
      images['backdrops'] = all_images['backdrops'] if images['backdrops'].empty?
      images['posters'] = all_images['posters'] if images['posters'].empty?
    end

    images['backdrops'].each do |backdrop|
      add_backdrop(result, backdrop)
    end
    images['posters'].each do |poster|
      add_poster(result, poster)
    end
    result
  end

  def collection_images(id)
    result = []
    images = invoke("/collection/#{id}/images", 'language' => @language)
    images ||= {}
    images['backdrops'] ||= []
    images['posters'] ||= []

    if images['backdrops'].empty? or images['posters'].empty?
      all_images = invoke("/collection/#{id}/images")
      all_images ||= {}
      all_images['backdrops'] ||= []
      all_images['posters'] ||= []
      images['backdrops'] = all_images['backdrops'] if images['backdrops'].empty?
      images['posters'] = all_images['posters'] if images['posters'].empty?
    end

    images['backdrops'].each do |backdrop|
      add_backdrop(result, backdrop)
    end
    images['posters'].each do |poster|
      add_poster(result, poster)
    end
    result
  end

  def invoke(uri, params = {})
    params['api_key'] = @api_key unless params['api_key']
    @engine.get("/3#{uri}", params)
  end

end
