class MovieGenre < ActiveRecord::Base
  attr_accessible :name
  has_many :movie_categories, :dependent => :destroy
  has_many :movies, :through => :movie_categories, :uniq => true, :order => :sort_title

  def movie_count
    movies.count
  end

end
