class MovieGenresController < ApplicationController
  layout 'movies'

  def index
    @genres = MovieGenre.order(:name)

    respond_to do |format|
      format.html
      format.json { render json: @genres }
    end
  end

  def show
    @genre = MovieGenre.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @movie_genre }
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
