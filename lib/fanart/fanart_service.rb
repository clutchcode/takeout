class FanartService
  HOST = 'api.fanart.tv'
  PORT = 80

  def initialize
    @engine = ApiEngine.new('fanart', HOST, PORT)
    @engine.json = true
    @api_key = ApiKey.get_key('fanart')
  end

  def artist_all(mbid)
    params = { :mbid => mbid, :type => 'all' }
    invoke('/webservice/artist', params)
  end

  def artist_backdrops(mbid)
    params = { :mbid => mbid, :type => 'artistbackground' }
    invoke('/webservice/artist', params)
  end

  def artist_thumbs(mbid)
    params = { :mbid => mbid, :type => 'artistthumbs' }
    invoke('/webservice/artist', params)
  end

  def invoke(uri, params = {})
    params[:sort] ||= 1
    params[:format] ||= 'json'
    params[:limit] ||= 1
    params[:api_key] ||= @api_key
    @engine.get("#{uri}/#{params[:api_key]}/#{params[:mbid]}/#{params[:format]}/#{params[:type]}/#{params[:sort]}/#{params[:limit]}/")
  end

end
