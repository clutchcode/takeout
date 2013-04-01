class MusicMember < ActiveRecord::Base
  has_many :music_credits
  has_many :music_albums, :through => :music_credits
  has_many :movie_images, :dependent => :destroy
  attr_accessible :name
end
