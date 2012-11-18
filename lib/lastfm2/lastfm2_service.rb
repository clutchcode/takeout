#require 'api_engine'

class Lastfm2Service
  HOST = 'ws.audioscrobbler.com'
  PORT = 80
  API_KEY = '7848c7336a28cc4464c4993ac7f1455e'

  def initialize
    @engine = ApiEngine.new('lastfm', HOST, PORT)
    @engine.json = true
    @api_key = API_KEY
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

#service = Lastfm2Service.new
#info = service.artist_info(:artist => "Gary Numan")
#p info
