class WelcomeController < ApplicationController
  def show
    @movies = Movie.modified(5)
    @albums = MusicAlbum.modified(5)

    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end
end