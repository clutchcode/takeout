class MovieCollectionsController < ApplicationController
  layout 'movies'

  def index
    @collections = MovieCollection.order(:sort_name)

    respond_to do |format|
      format.html
      format.json { render json: @collections }
    end
  end

  def show
    @collection = MovieCollection.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @collection }
    end
  end

end
