class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.average(:score).to_f
    # Tehtävä 5, esim:
    # ratings.map{|key| key.score}.inject(:+).to_f / ratings.size
  end

  def to_s
    name + ", " + brewery.name
  end
end
