class MusicCredit < ActiveRecord::Base
  belongs_to :music_album
  belongs_to :music_member
  attr_accessible :credit, :department, :job

  def name
    music_member.name
  end
end
