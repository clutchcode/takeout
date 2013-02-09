class MoviesController < ApplicationController
  layout 'application'

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.order(:sort_title)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html { render template_name }# show.html.erb
      format.js
      format.json { render json: @movie }
    end
  end

  def posters
    @movie = Movie.find(params[:id])
    @movie_posters = @movie.movie_images.where(:type => 'poster')

    respond_to do |format|
      format.html { render 'movie_posters/index'}
      format.json { render json: @movie_posters }
    end
  end

  def backdrops
    @movie = Movie.find(params[:id])
    @movie_backdrops = @movie.movie_images.where(:type => 'backdrop')

    respond_to do |format|
      format.html { render 'movie_backdrops/index'}
      format.json { render json: @movie_backdrops }
    end
  end

  def credits
    @movie = Movie.find(params[:id])
    @movie_credits = @movie.movie_credits

    respond_to do |format|
      format.html { render 'movie_credits/index'}
      format.json { render json: @movie_credits }
    end
  end

  def cast
    @movie = Movie.find(params[:id])
    @movie_credits = @movie.cast

    respond_to do |format|
      format.html { render 'movie_credits/index'}
      format.json { render json: @movie_credits }
    end
  end

  def genres
    @movie = Movie.find(params[:id])
    @movie_genres = @movie.movie_genres

    respond_to do |format|
      format.html { render 'movie_genres/index'}
      format.json { render json: @movie_genres }
    end
  end

  after_filter :check_disposition

  def stream
    @movie = Movie.find(params[:id])
    send_file @movie.file_uri, :disposition => 'inline', :type => 'video/mp4'
    #response.headers['X-SendFile'] = @movie.file_uri
    #response.headers['Content-Type'] = 'video/x-matroska'
    #render :nothing => true
  end

  def check_disposition
    if request.headers['HTTP_USER_AGENT'] =~ /Silk-Accelerated/i
      response.headers.delete('Content-Disposition')
      response.headers.delete('Content-Transfer-Encoding')
    end
  end
end
