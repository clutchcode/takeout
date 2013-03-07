class MusicGenresController < ApplicationController
  layout 'music'

  def index
    @genres = MusicGenre.order(:name)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @genre = MusicGenre.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def artists
    @artists = MusicGenre.find(params[:id]).music_artists.order(:sort_name)

    respond_to do |format|
      format.html { render 'music_artists/index'}
      format.json
    end
  end

  def albums
    @albums = MusicGenre.find(params[:id]).music_albums.order(:sort_title)

    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json
    end
  end

  def songs
    @genre = MusicGenre.find(params[:id])
    @songs = @genre.music_songs.order(:title)
    @title = @genre.name

    respond_to do |format|
      format.html { render 'music_songs/index'}
      format.json
    end
  end

  def tracks
    songs
  end
end
