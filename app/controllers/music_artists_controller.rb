class MusicArtistsController < ApplicationController
  def index
    @artists = MusicArtist.order(:sort_name)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @artists }
    end
  end

  def show
    @artist = MusicArtist.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @artist }
    end
  end

  ## GET /music_artists/new
  ## GET /music_artists/new.json
  #def new
  #  @music_artist = MusicArtist.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @music_artist }
  #  end
  #end
  #
  ## GET /music_artists/1/edit
  #def edit
  #  @music_artist = MusicArtist.find(params[:id])
  #end
  #
  ## POST /music_artists
  ## POST /music_artists.json
  #def create
  #  @music_artist = MusicArtist.new(params[:music_artist])
  #
  #  respond_to do |format|
  #    if @music_artist.save
  #      format.html { redirect_to @music_artist, notice: 'Music artist was successfully created.' }
  #      format.json { render json: @music_artist, status: :created, location: @music_artist }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @music_artist.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PUT /music_artists/1
  ## PUT /music_artists/1.json
  #def update
  #  @music_artist = MusicArtist.find(params[:id])
  #
  #  respond_to do |format|
  #    if @music_artist.update_attributes(params[:music_artist])
  #      format.html { redirect_to @music_artist, notice: 'Music artist was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @music_artist.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /music_artists/1
  ## DELETE /music_artists/1.json
  #def destroy
  #  @music_artist = MusicArtist.find(params[:id])
  #  @music_artist.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to music_artists_url }
  #    format.json { head :no_content }
  #  end
  #end
  #

  def test
    @music_artist = MusicArtist.all.first
    respond_to do |format|
      format.html
      format.js
    end
  end
end
