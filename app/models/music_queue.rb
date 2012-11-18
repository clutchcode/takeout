class MusicQueue < ActiveRecord::Base
  self.table_name = 'music_queue'
  belongs_to :music_song

  def self.<<(music_song)
    q = MusicQueue.new
    q.music_song = music_song
    q.save!
  end
end
