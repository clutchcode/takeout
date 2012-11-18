# Artist API: http://fanart.tv/webservice/artist/apikey/musicbrainz_mbid/format/type/sort/limit/
# Album API: http://fanart.tv/webservice/album/apikey/musicbrainz_release-group_mbid/format/type/sort/limit/
# Record Label API: http://fanart.tv/webservice/label/apikey/musicbrainz_label_mbid/format/type/sort/limit/
#format
#Returns the results in the requested format
#json (default) / xml / php (returns a php serialized object)
#type
#Returns the requested image types
#all (default) / cdart / artistbackground / albumcover / musiclogo / artistthumbs
#sort
#1 – Sorted by most popular image then newest(default)
#2 – Sorted by newest uploaded image
#3 – Sorted by oldest uploaded image
#limit
#Value is either 1 (1 image) or 2 (all images – default), for example, when automatically downloading images you might only want to return the first result so the user doesn’t have to provide input, whereas with a manual download you might want the user to see all the options.

class FanartService
  HOST = 'api.fanart.tv'
  PORT = 80
  API_KEY = 'e4967f4f625098ecf0666446ca70f7b5'

  def initialize
    @engine = ApiEngine.new('fanart', HOST, PORT)
    @engine.json = true
    @api_key = API_KEY
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
