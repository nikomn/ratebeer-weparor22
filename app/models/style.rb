class Style < ApplicationRecord
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def self.top_rated(n)
    return Style.all.sort_by{ |s| s.average_rating }.reverse.first(n)
  end
end
