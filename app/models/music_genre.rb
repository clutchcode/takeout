class MusicGenre < ActiveRecord::Base
  attr_accessible :name
  has_many :music_categories
  has_many :music_songs, :through => :music_categories, :uniq => true
  has_many :music_albums, :through => :music_songs, :uniq => true
  has_many :music_artists, :through => :music_albums, :uniq => true

  def song_count
    music_songs.count
  end

  def album_count
    music_albums.count
  end

  def artist_count
    music_artists.count
  end
end