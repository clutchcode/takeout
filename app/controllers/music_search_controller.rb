class MusicSearchController < ApplicationController
  def index
    keyword = params['q']
    results = MusicBusiness.new.search(keyword)
    @albums = results[:albums]
    @artists = results[:artists]
    @genres = results[:genres]
    @songs = results[:songs]

    respond_to do |format|
      format.html
    end
  end
end
