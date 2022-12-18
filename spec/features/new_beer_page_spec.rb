require 'rails_helper'

include Helpers

describe "New beer page" do
  before :each do
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end

  describe "when brewery and style exists" do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @brewery = FactoryBot.create(:brewery, name: "Koff", year: 1900)
      @style = FactoryBot.create(:style)
    end

    it "it is possible to create new beers with valid name" do
      visit new_beer_path
      fill_in('beer_name', with: 'New beer')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "it shows error message if new beer has invalid name" do
      visit new_beer_path

      fill_in('beer_name', with: '')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(page).to have_content "Name can't be blank"
    end

  end
end