class MovieGenre < ActiveRecord::Base
  attr_accessible :name
  has_many :movie_categories
  has_many :movies, :through => :movie_categories, :uniq => true

  def movie_count
    movies.count
  end

end
