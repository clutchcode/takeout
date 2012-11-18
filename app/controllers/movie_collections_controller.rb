class MovieCollectionsController < ApplicationController
  # GET /movie_collections
  # GET /movie_collections.json
  def index
    @movie_collections = MovieCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movie_collections }
    end
  end

  # GET /movie_collections/1
  # GET /movie_collections/1.json
  def show
    @movie_collection = MovieCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie_collection }
    end
  end

  # GET /movie_collections/new
  # GET /movie_collections/new.json
  def new
    @movie_collection = MovieCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie_collection }
    end
  end

  # GET /movie_collections/1/edit
  def edit
    @movie_collection = MovieCollection.find(params[:id])
  end

  # POST /movie_collections
  # POST /movie_collections.json
  def create
    @movie_collection = MovieCollection.new(params[:movie_collection])

    respond_to do |format|
      if @movie_collection.save
        format.html { redirect_to @movie_collection, notice: 'Movie collection was successfully created.' }
        format.json { render json: @movie_collection, status: :created, location: @movie_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @movie_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movie_collections/1
  # PUT /movie_collections/1.json
  def update
    @movie_collection = MovieCollection.find(params[:id])

    respond_to do |format|
      if @movie_collection.update_attributes(params[:movie_collection])
        format.html { redirect_to @movie_collection, notice: 'Movie collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_collections/1
  # DELETE /movie_collections/1.json
  def destroy
    @movie_collection = MovieCollection.find(params[:id])
    @movie_collection.destroy

    respond_to do |format|
      format.html { redirect_to movie_collections_url }
      format.json { head :no_content }
    end
  end
end
