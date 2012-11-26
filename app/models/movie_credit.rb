class MovieCredit < ActiveRecord::Base
  belongs_to :movie
  belongs_to :movie_member
  attr_accessible :character, :department, :job, :sort_order

  def name
    movie_member.name
  end

  def self.actors
    MovieCredit.where(:job => 'Actor').includes(:movie_member)
  end

  def self.directors
    MovieCredit.where(:job => 'Director').includes(:movie_member)
  end

  def self.writers
    MovieCredit.where(:job => 'Writer').includes(:movie_member)
  end

  def self.producers
    MovieCredit.includes(:movie_members).where(:job => 'Producer')
  end
end
