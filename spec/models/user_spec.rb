require 'rails_helper'

RSpec.describe User, type: :model do
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
    let(:user){ User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1" }
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:test_beer) { Beer.create name: "testbeer", style: "teststyle", brewery: test_brewery }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score: 10, beer: test_beer
      rating2 = Rating.new score: 20, beer: test_beer

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end