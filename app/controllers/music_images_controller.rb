class MusicImagesController < ApplicationController
  def show
    @music_image = MusicImage.find(params[:id])
    cache = ImageCache.new
    file = cache.fetch(@music_image.url)
    send_file file
  end
end
