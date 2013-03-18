class MovieMember < ActiveRecord::Base
  has_many :movie_credits, :include => :movie, :order => 'movies.release_date'
  has_many :movies, :through => :movie_credits, :uniq => true
  has_many :movie_images
  attr_accessible :name, :sort_name, :tmdb_id

  def sort_char
    sort_name.first.capitalize
  end

  def thumb
    thumbs.first
  end

  def thumbs
    movie_images.where(:image_type => 'profile', :size => 'w45')
  end

  def profile
    profiles.first
  end

  def profiles
    movie_images.where(:image_type => 'profile', :size => 'w185')
  end

  def movie_count
    movies.count
  end

  def self.producers
    has_job('Producer')
  end

  def self.actors
    has_job('Actor')
  end

  def self.directors
    has_job('Director')
  end

  def self.writers
    has_job('Writer')
  end

  def self.has_job(job)
    MovieMember.joins(:movie_credits).where('movie_credits.job' => job).order(:sort_name).uniq
  end

end
