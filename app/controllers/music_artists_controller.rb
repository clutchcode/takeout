class MusicArtistsController < ApplicationController
  layout 'music'

  def index
    @artists = MusicArtist.order(:sort_name)

    respond_to do |format|
      format.html
      format.json { render json: @artists }
    end
  end

  def show
    @artist = MusicArtist.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @artist }
    end
  end
end
