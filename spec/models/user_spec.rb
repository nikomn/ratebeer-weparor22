require 'rails_helper'

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

RSpec.describe User, type: :model do
  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
    # expect(user.username).to be("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    #expect(user.valid?).to be(false)
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with password using small letters only" do
    user = User.create username: "Pekka", password: "salainen"

    #expect(user.valid?).to be(false)
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with password that is too short" do
    user = User.create username: "Pekka", password: "aB1"

    #expect(user.valid?).to be(false)
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  # it "is saved with a proper password" do
  #   user = User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1"
  #
  #   # expect(user.valid?).to be(true)
  #   expect(user).to be_valid
  #   expect(User.count).to eq(1)
  # end
  #
  # it "with a proper password and two ratings, has the correct average rating" do
  #   user = User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1"
  #   brewery = Brewery.new name: "test", year: 2000
  #   beer = Beer.new name: "testbeer", style: "teststyle", brewery: brewery
  #   rating = Rating.new score: 10, beer: beer
  #   rating2 = Rating.new score: 20, beer: beer
  #
  #   user.ratings << rating
  #   user.ratings << rating2
  #
  #   expect(user.ratings.count).to eq(2)
  #   expect(user.average_rating).to eq(15.0)
  # end
  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end