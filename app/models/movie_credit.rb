class MovieCredit < ActiveRecord::Base
  belongs_to :movie
  belongs_to :movie_member
  attr_accessible :character, :department, :job, :sort_order

  def name
    movie_member.name
  end
end
