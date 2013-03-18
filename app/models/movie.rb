class Movie < ActiveRecord::Base
  attr_accessible  :file_uri, :imdb_id, :last_modified, :overview, :rating, :release_date, :runtime, :sort_title, :tagline, :tmdb_id, :title
  has_many :movie_images
  has_many :movie_credits
  has_many :movie_categories
  has_many :movie_genres, :through => :movie_categories, :uniq => true
  belongs_to :movie_collection

  def year
    release_date.year
  end

  def cast
    movie_credits.where(:job => 'Actor').order(:sort_order)
  end

  def director
    movie_credits.where(:job => 'Director').first
  end

  def directors
    movie_credits.where(:job => 'Director').order(:sort_order)
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

  def genres
    movie_genres.order(:name)
  end

  def self.modified(limit = 1)
    Movie.order('last_modified desc').limit(limit)
  end

  def self.added(limit = 1)
    Movie.order('created_at desc').limit(limit)
  end

  def self.released(limit = 1)
    Movie.order('release_date desc').limit(limit)
  end

end
