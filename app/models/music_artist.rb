class MusicArtist < ActiveRecord::Base
  attr_accessible :mbid, :name, :overview, :sort_name
  has_many :music_albums, :uniq => true
  has_many :music_images
  has_many :music_songs, :through => :music_albums
  has_many :music_genres, :through => :music_albums, :uniq => true, :order => :name

  scope :with_name_like, lambda { |pattern| { :conditions => ['name like ?', "%#{pattern}%"] } }

  def album_count
    music_albums.count
  end

  def song_count
    music_songs.count
  end

  def albums_by_date
    music_albums.order('original_date asc')
  end

  def self.artist_count
    MusicArtist.count
  end
end
