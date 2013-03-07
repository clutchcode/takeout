class SettingsController < ApplicationController
  def scan
  end

  def music_scan
    Thread.new do
      MusicBusiness.new.scan
    end
    render :nothing => true
  end

  def movie_scan
    render :nothing => true
  end
end
