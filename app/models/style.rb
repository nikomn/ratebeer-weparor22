class Style < ApplicationRecord
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def self.top_rated(num)
    Style.all.sort_by(&:average_rating).reverse.first(num)
  end
end
