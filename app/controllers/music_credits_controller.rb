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

  ## GET /music_credits/new
  ## GET /music_credits/new.json
  #def new
  #  @music_credit = MusicCredit.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @music_credit }
  #  end
  #end
  #
  ## GET /music_credits/1/edit
  #def edit
  #  @music_credit = MusicCredit.find(params[:id])
  #end
  #
  ## POST /music_credits
  ## POST /music_credits.json
  #def create
  #  @music_credit = MusicCredit.new(params[:music_credit])
  #
  #  respond_to do |format|
  #    if @music_credit.save
  #      format.html { redirect_to @music_credit, notice: 'Music credit was successfully created.' }
  #      format.json { render json: @music_credit, status: :created, location: @music_credit }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @music_credit.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PUT /music_credits/1
  ## PUT /music_credits/1.json
  #def update
  #  @music_credit = MusicCredit.find(params[:id])
  #
  #  respond_to do |format|
  #    if @music_credit.update_attributes(params[:music_credit])
  #      format.html { redirect_to @music_credit, notice: 'Music credit was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @music_credit.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## DELETE /music_credits/1
  ## DELETE /music_credits/1.json
  #def destroy
  #  @music_credit = MusicCredit.find(params[:id])
  #  @music_credit.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to music_credits_url }
  #    format.json { head :no_content }
  #  end
  #end
end
