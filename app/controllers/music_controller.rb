class MusicController < ApplicationController
  def artists
    @artists = MusicArtist.order(:sort_name)
    respond_to do |format|
      format.json { render json: @artists }
    end
  end

  def albums
    @albums = MusicAlbum.order(:sort_title)
    respond_to do |format|
      format.json { render json: @albums }
    end
  end

  def songs
    @songs = MusicSong.order(:title)
    respond_to do |format|
      format.json { render json: @songs }
    end
  end

  def tracks
    songs
  end

end