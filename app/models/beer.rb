class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  # has_many :raters, through: :ratings, source: :user
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

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

  def self.top_rated(n)
    return Beer.all.sort_by{ |b| b.average_rating }.reverse.first(n)
  end
end
