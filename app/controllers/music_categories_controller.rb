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

  # GET /music_categories/new
  # GET /music_categories/new.json
  def new
    @music_category = MusicCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music_category }
    end
  end

  # GET /music_categories/1/edit
  def edit
    @music_category = MusicCategory.find(params[:id])
  end

  # POST /music_categories
  # POST /music_categories.json
  def create
    @music_category = MusicCategory.new(params[:music_category])

    respond_to do |format|
      if @music_category.save
        format.html { redirect_to @music_category, notice: 'Music category was successfully created.' }
        format.json { render json: @music_category, status: :created, location: @music_category }
      else
        format.html { render action: "new" }
        format.json { render json: @music_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /music_categories/1
  # PUT /music_categories/1.json
  def update
    @music_category = MusicCategory.find(params[:id])

    respond_to do |format|
      if @music_category.update_attributes(params[:music_category])
        format.html { redirect_to @music_category, notice: 'Music category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @music_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_categories/1
  # DELETE /music_categories/1.json
  def destroy
    @music_category = MusicCategory.find(params[:id])
    @music_category.destroy

    respond_to do |format|
      format.html { redirect_to music_categories_url }
      format.json { head :no_content }
    end
  end
end
