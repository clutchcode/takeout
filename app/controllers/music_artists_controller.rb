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

  def songs
    @artist = MusicArtist.find(params[:id])
    albums = @artist.music_albums.uniq.map { |album| album.id }
    @songs = MusicSong.find_all_by_music_album_id(albums)

    respond_to do |format|
      format.html { render 'music_songs/index' }
      format.json
    end
  end
end
