class MovieMembersController < ApplicationController
  layout 'movies'

  def index
    @members = MovieMember.order(:name)
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

  def actors
    @title = t :actors
    @members = MovieMember.actors
    members
  end

  def directors
    @title = t :directors
    @members = MovieMember.directors
    members
  end

  def producers
    @title = t :producers
    @members = MovieMember.producers
    members
  end

  def writers
    @title = t :writers
    @members = MovieMember.writers
    members
  end

  def show
    @member = MovieMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  def movies
    @member = MovieMember.find(params[:id])
    @movies = @member.movies.order(:sort_title)

    respond_to do |format|
      format.html { render 'movies/index'}
      format.json { render json: @movies }
    end
  end
end
