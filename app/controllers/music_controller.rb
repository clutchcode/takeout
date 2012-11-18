class MusicController < ApplicationController
  def show
    respond_to do |format|
      format.html { render :layout => 'music' }
    end
  end

  def artists
    @music_artists = MusicArtist.order(:sort_name)

    respond_to do |format|
      format.html { render 'music_artists/index'}
      format.json { render json: @music_artists }
    end
  end

  def albums
    @music_albums = MusicAlbum.order(:sort_title)

    respond_to do |format|
      format.html { render 'music_albums/index'}
      format.json { render json: @music_albums }
    end
  end

  def songs
    @music_songs = MusicSong.order(:title)

    respond_to do |format|
      format.html { render 'music_songs/index'}
      format.json { render json: @music_songs }
    end
  end

  def tracks
    songs
  end

end