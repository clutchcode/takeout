class MusicSong < ActiveRecord::Base
  attr_accessible :bitrate, :channel_mode, :file_uri, :has_cover, :last_modified, :length, :part, :sample_rate, :set, :title, :track, :vbr, :year
  has_many :music_categories
  has_many :music_genres, :through => :music_categories, :uniq => true
  belongs_to :music_album

  def music_artist
    music_album.music_artist
  end
end
