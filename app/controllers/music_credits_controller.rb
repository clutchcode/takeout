class MusicCreditsController < ApplicationController
  # GET /music_credits
  # GET /music_credits.json
  def index
    @music_credits = MusicCredit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_credits }
    end
  end

  # GET /music_credits/1
  # GET /music_credits/1.json
  def show
    @music_credit = MusicCredit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_credit }
    end
  end

end
