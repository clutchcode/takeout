class FanartService
  HOST = 'api.fanart.tv'
  PORT = 80

  def initialize
    @engine = ApiEngine.new('fanart', HOST, PORT)
    @engine.json = true
    @api_key = ApiKey.get_key('fanart')
  end

  def artist_backdrops(mbid)
    params = { :mbid => mbid, :type => 'artistbackground' }
    invoke('/webservice/artist', params)
  end

  def album_covers(mbid)
    params = { :mbid => mbid, :type => 'albumcover' }
    invoke('/webservice/album', params)
  end

  def artist_thumbs(mbid)
    params = { :mbid => mbid, :type => 'artistthumbs' }
    invoke('/webservice/artist', params)
  end

  def invoke(uri, params = {})
    params[:sort] ||= 1
    params[:format] ||= 'json'
    params[:limit] ||= 2
    params[:api_key] ||= @api_key
    @engine.get("#{uri}/#{params[:api_key]}/#{params[:mbid]}/#{params[:format]}/#{params[:type]}/#{params[:sort]}/#{params[:limit]}/")
  end

end

#service = FanartService.new
#p service.album_covers "2ba66802-18a7-3bf4-958c-db871a6e7f34"
#p service.album_covers "e0ea7166-292c-31de-870d-8c4622ec451b"
