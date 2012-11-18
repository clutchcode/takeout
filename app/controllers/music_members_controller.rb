class MusicMembersController < ApplicationController
  # GET /music_members
  # GET /music_members.json
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

  # GET /music_members/new
  # GET /music_members/new.json
  def new
    @music_member = MusicMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @music_member }
    end
  end

  # GET /music_members/1/edit
  def edit
    @music_member = MusicMember.find(params[:id])
  end

  # POST /music_members
  # POST /music_members.json
  def create
    @music_member = MusicMember.new(params[:music_member])

    respond_to do |format|
      if @music_member.save
        format.html { redirect_to @music_member, notice: 'Music member was successfully created.' }
        format.json { render json: @music_member, status: :created, location: @music_member }
      else
        format.html { render action: "new" }
        format.json { render json: @music_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /music_members/1
  # PUT /music_members/1.json
  def update
    @music_member = MusicMember.find(params[:id])

    respond_to do |format|
      if @music_member.update_attributes(params[:music_member])
        format.html { redirect_to @music_member, notice: 'Music member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @music_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_members/1
  # DELETE /music_members/1.json
  def destroy
    @music_member = MusicMember.find(params[:id])
    @music_member.destroy

    respond_to do |format|
      format.html { redirect_to music_members_url }
      format.json { head :no_content }
    end
  end
end
