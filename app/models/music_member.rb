class MusicMember < ActiveRecord::Base
  has_many :music_credits
  has_many :music_albums, :through => :music_credits, :uniq => true
  has_many :movie_images, :dependent => :destroy
  attr_accessible :name, :sort_name

  def sort_char
    sort_name.first.capitalize
  end

  def self.performers
    has_job('Performer')
  end

  def self.has_job(job)
    MusicMember.joins(:music_credits).where('music_credits.job' => job).order(:sort_name).uniq
  end
end
