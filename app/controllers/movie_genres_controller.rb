class MovieGenresController < ApplicationController
  # GET /movie_genres
  # GET /movie_genres.json
  def index
    @genres = MovieGenre.order(:name)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @genres }
    end
  end

  # GET /movie_genres/1
  # GET /movie_genres/1.json
  def show
    @genre = MovieGenre.find(params[:id])
    #@movies = @genre.movies.order(:sort_title)

    respond_to do |format|
      format.html { render 'movies/index'}
      format.js
      format.json { render json: @movie_genre }
    end
  end

  # GET /movie_genres/new
  # GET /movie_genres/new.json
  def new
    @movie_genre = MovieGenre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie_genre }
    end
  end

  # GET /movie_genres/1/edit
  def edit
    @movie_genre = MovieGenre.find(params[:id])
  end

  # POST /movie_genres
  # POST /movie_genres.json
  def create
    @movie_genre = MovieGenre.new(params[:movie_genre])

    respond_to do |format|
      if @movie_genre.save
        format.html { redirect_to @movie_genre, notice: 'Movie genre was successfully created.' }
        format.json { render json: @movie_genre, status: :created, location: @movie_genre }
      else
        format.html { render action: "new" }
        format.json { render json: @movie_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movie_genres/1
  # PUT /movie_genres/1.json
  def update
    @movie_genre = MovieGenre.find(params[:id])

    respond_to do |format|
      if @movie_genre.update_attributes(params[:movie_genre])
        format.html { redirect_to @movie_genre, notice: 'Movie genre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_genres/1
  # DELETE /movie_genres/1.json
  def destroy
    @movie_genre = MovieGenre.find(params[:id])
    @movie_genre.destroy

    respond_to do |format|
      format.html { redirect_to movie_genres_url }
      format.json { head :no_content }
    end
  end

  def movies
    @movie_genre = MovieGenre.find(params[:id])
    @movies = @movie_genre.movies.order(:sort_title)

    respond_to do |format|
      format.html { render 'movies/index'}
      format.json { render json: @movies }
    end
  end
end
