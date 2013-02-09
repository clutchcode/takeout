class MusicAlbum < ActiveRecord::Base
  attr_accessible :asin, :mbid, :original_date, :release_country, :release_date, :release_status, :release_type, :sort_title, :title, :total_tracks, :total_length, :year
  belongs_to :music_artist
  has_many :music_songs, :uniq => true
  has_many :music_images
  has_many :music_credits
  has_many :music_genres, :through => :music_songs, :uniq => true

  #def total_length
  #  music_songs.sum(:length)
  #end

  def track_count
    total_tracks
  end

  def song_count
    total_tracks
  end

  def original_year
    original_date ? original_date.year : year
  end

  def self.modified(limit = 1)
    songs = MusicSong.order('last_modified desc').group('music_album_id').limit(limit)
    songs.map { |song| song.music_album }
  end

  def self.added(limit = 1)
    MusicAlbum.order('created_at desc').limit(limit)
  end

  def self.released(limit = 1)
    MusicAlbum.order('release_date desc').limit(limit)
  end

end
