class MusicGenresController < ApplicationController
  layout 'music'

  def index
    @genres = MusicGenre.order(:name)

    respond_to do |format|
      format.html
      format.json { render json: @genres }
    end
  end

  def show
    @genre = MusicGenre.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @genre }
    end
  end

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
