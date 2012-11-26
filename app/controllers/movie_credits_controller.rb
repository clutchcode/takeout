class MovieCreditsController < ApplicationController
  # GET /movie_credits
  # GET /movie_credits.json
  def index
    @movie_credits = MovieCredit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movie_credits }
    end
  end

  # GET /movie_credits/1
  # GET /movie_credits/1.json
  def show
    @movie_credit = MovieCredit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie_credit }
    end
  end

  def actors
    @credit = MovieCredit.where(:job => 'Actor')
  end

  def directors
    @credit = MovieCredit.where(:job => 'Director')
  end

  def writers
    @credit = MovieCredit.where(:job => 'Writer')
  end

  def producers
    @credit = MovieCredit.where(:job => 'Producer')
  end
end
