require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  # before :each do
  #   visit signin_path
  #   fill_in('username', with: 'Pekka')
  #   fill_in('password', with: 'Foobar1')
  #   click_button('Log in')
  # end

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows existing ratings and their count" do
    FactoryBot.create(:rating, score: 10, user: user)
    FactoryBot.create(:rating, score: 12, user: user)
    FactoryBot.create(:rating, score: 14, user: user)
    visit ratings_path
    # save_and_open_page
    expect(page).to have_content 'Number of ratings: 3'
    expect(page).to have_content 'anonymous 10'
    expect(page).to have_content 'anonymous 12'
    expect(page).to have_content 'anonymous 14'
  end
end