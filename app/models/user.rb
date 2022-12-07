class User < ApplicationRecord
  include RatingAverage
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: { with: /.*([A-Z]+.*[0-9]|[0-9]+.*[A-Z])/, on: :create }
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_secure_password
end
