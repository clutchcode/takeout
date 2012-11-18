class MovieMember < ActiveRecord::Base
  has_many :movie_credits
  has_many :movies, :through => :movie_credits
  has_many :movie_images
  attr_accessible :name

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
end
