class MusicCategory < ActiveRecord::Base
  belongs_to :music_genre
  belongs_to :music_song
end
