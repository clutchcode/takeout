class MovieCollection < ActiveRecord::Base
  attr_accessible :name
  has_many :movies, :order => :release_date
  has_many :movie_images

  def movie_count
    movies.count
  end
end
