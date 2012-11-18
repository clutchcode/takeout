require 'mp3info'

class MusicSongsController < ApplicationController
  # GET /music_songs
  # GET /music_songs.json
  def index
    @music_songs = MusicSong.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_songs }
    end
  end

  # GET /music_songs/1
  # GET /music_songs/1.json
  def show
    @music_song = MusicSong.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_song }
    end
  end

  # GET /music_songs/new
  # GET /music_songs/new.json
  def new
    @music_song = MusicSong.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music_song }
    end
  end

  # GET /music_songs/1/edit
  def edit
    @music_song = MusicSong.find(params[:id])
  end

  # POST /music_songs
  # POST /music_songs.json
  def create
    @music_song = MusicSong.new(params[:music_song])

    respond_to do |format|
      if @music_song.save
        format.html { redirect_to @music_song, notice: 'Music song was successfully created.' }
        format.json { render json: @music_song, status: :created, location: @music_song }
      else
        format.html { render action: "new" }
        format.json { render json: @music_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /music_songs/1
  # PUT /music_songs/1.json
  def update
    @music_song = MusicSong.find(params[:id])

    respond_to do |format|
      if @music_song.update_attributes(params[:music_song])
        format.html { redirect_to @music_song, notice: 'Music song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @music_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_songs/1
  # DELETE /music_songs/1.json
  def destroy
    @music_song = MusicSong.find(params[:id])
    @music_song.destroy

    respond_to do |format|
      format.html { redirect_to music_songs_url }
      format.json { head :no_content }
    end
  end

  def cover
    @music_song = MusicSong.find(params[:id])
    cache = ImageCache.new
    dir = File.dirname(@music_song.file_uri)
    covers = %w{ "#{dir}/cover.jpg", "#{dir}/cover.png", "#{dir}/cover.gif" }
    covers.keep_if { |cover| File.exists? cover }
    path = covers.first
    if path
      puts "using #{path}"
      path = "file://#{path}"
      file = cache.fetch(path)
    else
      cover = embedded_music_cover(@music_song)
      if cover[:type] =~ /gif/
        ext = 'gif'
      elsif cover[:type] =~ /png/
        ext = 'png'
      else
        ext = 'jpg'
      end
      path = "file://#{dir}/cover.#{ext}"
      file = cache.fetch(path, cover[:image])
    end
    send_file file
  end

  def stream
    @music_song = MusicSong.find(params[:id])
    send_file @music_song.file_uri
  end
end
