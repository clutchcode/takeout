class MusicCategoriesController < ApplicationController
  # GET /music_categories
  # GET /music_categories.json
  def index
    @music_categories = MusicCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_categories }
    end
  end

  # GET /music_categories/1
  # GET /music_categories/1.json
  def show
    @music_category = MusicCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_category }
    end
  end
end
