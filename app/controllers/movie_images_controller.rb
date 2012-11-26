class MovieImagesController < ApplicationController

  def show
    @movie_image = MovieImage.find(params[:id])
    cache = ImageCache.new
    file = cache.fetch(@movie_image.url)
    send_file file
  end

end
