class MusicGenresController < ApplicationController
  def index
    @genres = MusicGenre.order(:name)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @genres }
    end
  end

  def show
    @genre = MusicGenre.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @music_genre }
    end
  end

  ## GET /music_genres/new
  ## GET /music_genres/new.json
  #def new
  #  @music_genre = MusicGenre.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @music_genre }
  #  end
  #end
  #
  ## GET /music_genres/1/edit
  #def edit
  #  @music_genre = MusicGenre.find(params[:id])
  #end
  #
  ## POST /music_genres
  ## POST /music_genres.json
  #def create
  #  @music_genre = MusicGenre.new(params[:music_genre])
  #
  #  respond_to do |format|
  #    if @music_genre.save
  #      format.html { redirect_to @music_genre, notice: 'Music genre was successfully created.' }
  #      format.json { render json: @music_genre, status: :created, location: @music_genre }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @music_genre.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PUT /music_genres/1
  ## PUT /music_genres/1.json
  #def update
  #  @music_genre = MusicGenre.find(params[:id])
  #
  #  respond_to do |format|
  #    if @music_genre.update_attributes(params[:music_genre])
  #      format.html { redirect_to @music_genre, notice: 'Music genre was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @music_genre.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /music_genres/1
  ## DELETE /music_genres/1.json
  #def destroy
  #  @music_genre = MusicGenre.find(params[:id])
  #  @music_genre.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to music_genres_url }
  #    format.json { head :no_content }
  #  end
  #end

  def artists
    @music_artists = MusicGenre.find(params[:id]).music_artists.order(:sort_name)

    respond_to do |format|
      format.html { render 'music_artists/index'}
      format.json { render json: @music_artists }
    end
  end

  def albums
    @music_albums = MusicGenre.find(params[:id]).music_albums.order(:sort_title)

    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json { render json: @music_albums }
    end
  end

  def songs
    @music_songs = MusicGenre.find(params[:id]).music_songs.order(:title)

    respond_to do |format|
      format.html { render 'music_songs/index'}
      format.json { render json: @music_songs }
    end
  end

  def tracks
    songs
  end
end
