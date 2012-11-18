class MusicAlbum < ActiveRecord::Base
  attr_accessible :asin, :mbid, :original_date, :release_country, :release_date, :release_status, :release_type, :sort_title, :title, :year
  belongs_to :music_artist
  has_many :music_songs, :uniq => true
  has_many :music_images
  has_many :music_credits
  has_many :music_genres, :through => :music_songs, :uniq => true

  def total_length
    music_songs.sum(:length)
  end

  def track_count
    music_songs.count
  end

  def song_count
    track_count
  end
end
