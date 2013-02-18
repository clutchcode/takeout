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
      format.html
      format.json { render json: @album }
    end
  end

  def released
    @albums = MusicAlbum.released(params[:id] || 100)
    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json { render json: @albums }
    end
  end

  def modified
    @albums = MusicAlbum.modified(params[:id] || 100)
    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json { render json: @albums }
    end
  end

  def added
    @albums = MusicAlbum.added(params[:id] || 100)
    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json { render json: @albums }
    end
  end
end
