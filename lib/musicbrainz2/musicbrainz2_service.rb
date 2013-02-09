class Musicbrainz2Service
  SEARCH_HOST = 'search.musicbrainz.org'
  SEARCH_PORT = 80

  def initialize
    @engine = ApiEngine.new('musicbrainz2', SEARCH_HOST, SEARCH_PORT)
    @engine.json = true
    @api_key = ApiKey.get_key('musicbrainz2')
  end

  def artist_search(name)
    params = {}
    params['query'] = name
    invoke('artist', params)
  end

  def artist_mbid(name)
    result = artist_search(name)
    if result['artist-list'] and result['artist-list']['artist']
      return result['artist-list']['artist'].first['id']
    end
    nil
  end

  def invoke(resource, params = {})
    params['fmt'] ||= 'json'
    sleep(1)
    @engine.get("/ws/2/#{resource}/", params)
  end
end
