class MovieMembersController < ApplicationController
  layout 'movies'

  # GET /movie_members
  # GET /movie_members.json
  def index
    @members = MovieMember.directors

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /movie_members/1
  # GET /movie_members/1.json
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
