class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: true

  # def average_rating
  #   ratings.average(:score).to_f
  #   # Tehtävä 5, esim:
  #   # ratings.map{|key| key.score}.inject(:+).to_f / ratings.size
  # end

  def to_s
    "#{name}, #{brewery.name}"
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end
end
