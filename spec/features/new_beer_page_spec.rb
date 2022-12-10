require 'rails_helper'

describe "New beer page" do

  describe "when brewery exists" do
    before :each do
      # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
      @brewery = FactoryBot.create(:brewery, name: "Koff", year: 1900)
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