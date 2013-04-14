class MovieCollection < ActiveRecord::Base
  attr_accessible :name, :sort_name
  has_many :movies, :order => :release_date
  has_many :movie_images, :dependent => :destroy

  def movie_count
    movies.count
  end

  def thumb
    thumbs.first
  end

  def thumbs
    movie_images.where(:image_type => 'poster', :size => 'w92').order("sort_order desc")
  end

  def cover
    covers.first
  end

  def covers
    movie_images.where(:image_type => 'poster', :size => 'w154').order("sort_order desc")
  end

  def backdrop
    backdrops.first
  end

  def backdrops
    movie_images.where(:image_type => 'backdrop', :size => 'w1280').order("sort_order desc")
  end

  def poster
    posters.first
  end

  def posters
    movie_images.where(:image_type => 'poster', :size => 'w500').order("sort_order desc")
  end
end
