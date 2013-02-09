require 'mp3info'

class MusicSongsController < ApplicationController
  layout 'music'

  def index
    @music_songs = MusicSong.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_songs }
    end
  end

  def show
    @music_song = MusicSong.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_song }
    end
  end

  def cover
    @music_song = MusicSong.find(params[:id])
    @@cache ||= ActiveSupport::Cache.lookup_store(:memory_store)
    cache_key = "music_cover:#{@music_song.id}"
    file = @@cache.fetch(cache_key)
    unless file
      cache = ImageCache.new
      # try cover file first
      dir = File.dirname(@music_song.file_uri)
      covers = [ "#{dir}/cover.jpg", "#{dir}/cover.png", "#{dir}/cover.gif" ]
      covers.keep_if { |cover| File.exists? cover }
      path = covers.first
      if path
        path = "file://#{path}"
        file = cache.fetch(path)
      else
        cover = embedded_music_cover(@music_song)
        case cover[:type]
          when /gif/
            ext = 'gif'
          when /png/
            ext = 'png'
          else
            ext = 'jpg'
        end
        path = "file://#{dir}/cover.#{ext}"
        file = cache.fetch(path, cover[:image])
      end
      @@cache.write(cache_key, file)
    end
    send_file file
  end

  def stream
    @music_song = MusicSong.find(params[:id])
    send_file @music_song.file_uri
  end
end
