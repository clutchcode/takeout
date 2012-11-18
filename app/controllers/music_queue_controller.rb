class MusicQueueController < ApplicationController
  # GET /music_queue
  # GET /music_queue.json
  def index
    @music_queue = MusicQueue.includes(:music_song).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_queue }
    end
  end

  # GET /music_queue/
  # GET /music_queue/1.json
  def show
    @music_queue = MusicQueue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_queue }
    end
  end

  # POST /music_queue
  # POST /music_queue.json
  def create
    @music_album = MusicQueue.new(params[:music_queue])

    respond_to do |format|
      if @music_album.save
        format.html { redirect_to @music_album, notice: 'Music album was successfully created.' }
        format.json { render json: @music_album, status: :created, location: @music_album }
      else
        format.html { render action: "new" }
        format.json { render json: @music_album.errors, status: :unprocessable_entity }
      end
    end
  end

end
