class MusicImage < ActiveRecord::Base
  belongs_to :music_artist
  belongs_to :music_album
  attr_accessible :aspect_ratio, :height, :image_type, :language, :size, :sort_order, :source, :url, :width
end
