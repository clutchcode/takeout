class MovieCategory < ActiveRecord::Base
  belongs_to :movie
  belongs_to :movie_genre
end
