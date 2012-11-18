class MovieCollection < ActiveRecord::Base
  attr_accessible :name
  has_many :movies
  has_many :movie_images
end
