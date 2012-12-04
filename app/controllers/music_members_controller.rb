class MusicMembersController < ApplicationController

  def index
    @music_members = MusicMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @music_members }
    end
  end

  # GET /music_members/1
  # GET /music_members/1.json
  def show
    @music_member = MusicMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @music_member }
    end
  end
end
