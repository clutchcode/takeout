class Lastfm2Service
  HOST = 'ws.audioscrobbler.com'
  PORT = 80

  def initialize
    @engine = ApiEngine.new('lastfm2', HOST, PORT)
    @engine.json = true
    @api_key = ApiKey.get_key('lastfm2')
  end

  def artist_info(opts)
    params = {}
    params['mbid'] = opts[:mbid] if opts[:mbid]
    unless params['mbid']
      params['artist'] = opts[:artist] if opts[:artist]
    end
    invoke('artist.getInfo', params)
  end

  def album_info(opts)
    params = {}
    params['mbid'] = opts[:mbid] if opts[:mbid]
    unless params['mbid']
      params['artist'] = opts[:artist] if opts[:artist]
      params['album'] = opts[:album] if opts[:album]
    end
    invoke('album.getInfo', params)
  end

  def invoke(method, params = {})
    params['format'] ||= 'json'
    params['method'] = method
    params['api_key'] ||= @api_key
    @engine.get('/2.0/', params)
  end
end
