class MusicSong < ActiveRecord::Base
  attr_accessible :bitrate, :channel_mode, :file_uri, :has_cover, :last_modified, :length, :mbid, :sample_rate, :disc_number, :total_discs, :total_tracks, :title, :track_number, :vbr, :year
  has_many :music_categories, :dependent => :destroy
  has_many :music_genres, :through => :music_categories, :uniq => true
  belongs_to :music_album

  scope :with_title_like, lambda { |pattern| { :conditions => ['title like ?', "%#{pattern}%"] } }

  def music_artist
    music_album.music_artist
  end
end
