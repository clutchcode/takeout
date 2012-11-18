class MovieImage < ActiveRecord::Base
  belongs_to :movie
  belongs_to :movie_collection
  belongs_to :movie_member
  attr_accessible :aspect_ratio, :height, :language, :source, :size, :sort_order, :image_type, :url, :width
end
