require 'image_cache'

class MusicImagesController < ApplicationController
  # GET /music_images
  # GET /music_images.json
  def index
    @music_images = MusicImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_images }
    end
  end

  # GET /music_images/1
  # GET /music_images/1.json
  def show
    @music_image = MusicImage.find(params[:id])
    cache = ImageCache.new
    file = cache.fetch(@music_image.url)
    send_file file
  end

  # GET /music_images/new
  # GET /music_images/new.json
  def new
    @music_image = MusicImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music_image }
    end
  end

  # GET /music_images/1/edit
  def edit
    @music_image = MusicImage.find(params[:id])
  end

  # POST /music_images
  # POST /music_images.json
  def create
    @music_image = MusicImage.new(params[:music_image])

    respond_to do |format|
      if @music_image.save
        format.html { redirect_to @music_image, notice: 'Music image was successfully created.' }
        format.json { render json: @music_image, status: :created, location: @music_image }
      else
        format.html { render action: "new" }
        format.json { render json: @music_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /music_images/1
  # PUT /music_images/1.json
  def update
    @music_image = MusicImage.find(params[:id])

    respond_to do |format|
      if @music_image.update_attributes(params[:music_image])
        format.html { redirect_to @music_image, notice: 'Music image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @music_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_images/1
  # DELETE /music_images/1.json
  def destroy
    @music_image = MusicImage.find(params[:id])
    @music_image.destroy

    respond_to do |format|
      format.html { redirect_to music_images_url }
      format.json { head :no_content }
    end
  end
end
