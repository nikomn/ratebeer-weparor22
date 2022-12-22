class User < ApplicationRecord
  include RatingAverage
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: { with: /.*([A-Z]+.*[0-9]|[0-9]+.*[A-Z])/, on: :create }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_secure_password

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole

    # ratings.sort_by{ |r| r.score }.last.beer
    # ratings.sort_by(&:score).last.beer
    ratings.order(score: :desc).limit(1).first.beer
  end

  def self.most_active(n)
    return User.all.sort_by{ |b| b.ratings.count }.reverse.first(n)
  end
end
