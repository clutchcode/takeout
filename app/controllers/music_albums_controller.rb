class MusicAlbumsController < ApplicationController
  layout 'music'

  def index
    @albums = MusicAlbum.order(:sort_title)

    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end

  def show
    @album = MusicAlbum.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'fullscreen' }
      format.json { render json: @album }
    end
  end
end
