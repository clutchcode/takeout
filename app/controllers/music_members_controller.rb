class MusicMembersController < ApplicationController
  layout 'music'

  def index
    @members = MusicMember.order(:name)
    members
  end

  def members
    @member_groups = {}
    @members.each do |member|
      @member_groups[member.sort_char] ||= []
      @member_groups[member.sort_char] << member
    end

    respond_to do |format|
      format.html { render 'index'}
      format.json { render json: @members }
    end
  end

  def performers
    @title = t :performers
    @members = MusicMember.performers
    members
  end

  def show
    @member = MusicMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  def artists
    @member = MusicMember.find(params[:id])
    @artists = @member.music_artists.order(:sort_name)

    respond_to do |format|
      format.html { render 'music_arists/index'}
      format.json { render json: @artists }
    end
  end
end

