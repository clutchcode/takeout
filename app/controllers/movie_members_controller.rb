class MovieMembersController < ApplicationController
  # GET /movie_members
  # GET /movie_members.json
  def index
    @movie_members = MovieMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movie_members }
    end
  end

  # GET /movie_members/1
  # GET /movie_members/1.json
  def show
    @movie_member = MovieMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie_member }
    end
  end

  # GET /movie_members/new
  # GET /movie_members/new.json
  def new
    @movie_member = MovieMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie_member }
    end
  end

  # GET /movie_members/1/edit
  def edit
    @movie_member = MovieMember.find(params[:id])
  end

  # POST /movie_members
  # POST /movie_members.json
  def create
    @movie_member = MovieMember.new(params[:movie_member])

    respond_to do |format|
      if @movie_member.save
        format.html { redirect_to @movie_member, notice: 'Movie member was successfully created.' }
        format.json { render json: @movie_member, status: :created, location: @movie_member }
      else
        format.html { render action: "new" }
        format.json { render json: @movie_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movie_members/1
  # PUT /movie_members/1.json
  def update
    @movie_member = MovieMember.find(params[:id])

    respond_to do |format|
      if @movie_member.update_attributes(params[:movie_member])
        format.html { redirect_to @movie_member, notice: 'Movie member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_members/1
  # DELETE /movie_members/1.json
  def destroy
    @movie_member = MovieMember.find(params[:id])
    @movie_member.destroy

    respond_to do |format|
      format.html { redirect_to movie_members_url }
      format.json { head :no_content }
    end
  end

  def movies
    @movie_member = MovieMember.find(params[:id])
    @movies = @movie_member.movies.order(:sort_title)

    respond_to do |format|
      format.html { render 'movies/index'}
      format.json { render json: @movies }
    end
  end
end
