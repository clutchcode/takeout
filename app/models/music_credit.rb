class MusicCredit < ActiveRecord::Base
  belongs_to :music_album
  belongs_to :music_member
  belongs_to :music_artist
  attr_accessible :credit, :department, :job

  def name
    music_member.name
  end
end
