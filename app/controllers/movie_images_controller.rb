class MovieImagesController < ApplicationController
  # GET /movie_images
  # GET /movie_images.json
  def index
    @movie_images = MovieImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movie_images }
    end
  end

  # GET /movie_images/1
  # GET /movie_images/1.json
  def show
    @movie_image = MovieImage.find(params[:id])
    cache = ImageCache.new
    file = cache.fetch(@movie_image.url)
    send_file file
  end

  # GET /movie_images/new
  # GET /movie_images/new.json
  def new
    @movie_image = MovieImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie_image }
    end
  end

  # GET /movie_images/1/edit
  def edit
    @movie_image = MovieImage.find(params[:id])
  end

  # POST /movie_images
  # POST /movie_images.json
  def create
    @movie_image = MovieImage.new(params[:movie_image])

    respond_to do |format|
      if @movie_image.save
        format.html { redirect_to @movie_image, notice: 'Movie image was successfully created.' }
        format.json { render json: @movie_image, status: :created, location: @movie_image }
      else
        format.html { render action: "new" }
        format.json { render json: @movie_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movie_images/1
  # PUT /movie_images/1.json
  def update
    @movie_image = MovieImage.find(params[:id])

    respond_to do |format|
      if @movie_image.update_attributes(params[:movie_image])
        format.html { redirect_to @movie_image, notice: 'Movie image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_images/1
  # DELETE /movie_images/1.json
  def destroy
    @movie_image = MovieImage.find(params[:id])
    @movie_image.destroy

    respond_to do |format|
      format.html { redirect_to movie_images_url }
      format.json { head :no_content }
    end
  end
end
