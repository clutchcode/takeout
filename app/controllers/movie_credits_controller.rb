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

  # GET /movie_credits/new
  # GET /movie_credits/new.json
  def new
    @movie_credit = MovieCredit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie_credit }
    end
  end

  # GET /movie_credits/1/edit
  def edit
    @movie_credit = MovieCredit.find(params[:id])
  end

  # POST /movie_credits
  # POST /movie_credits.json
  def create
    @movie_credit = MovieCredit.new(params[:movie_credit])

    respond_to do |format|
      if @movie_credit.save
        format.html { redirect_to @movie_credit, notice: 'Movie credit was successfully created.' }
        format.json { render json: @movie_credit, status: :created, location: @movie_credit }
      else
        format.html { render action: "new" }
        format.json { render json: @movie_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movie_credits/1
  # PUT /movie_credits/1.json
  def update
    @movie_credit = MovieCredit.find(params[:id])

    respond_to do |format|
      if @movie_credit.update_attributes(params[:movie_credit])
        format.html { redirect_to @movie_credit, notice: 'Movie credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_credits/1
  # DELETE /movie_credits/1.json
  def destroy
    @movie_credit = MovieCredit.find(params[:id])
    @movie_credit.destroy

    respond_to do |format|
      format.html { redirect_to movie_credits_url }
      format.json { head :no_content }
    end
  end
end
