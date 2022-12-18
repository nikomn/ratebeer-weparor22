require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:test_brewery) { Brewery.new name: "test", year: 2000 }
  let(:test_style) { Style.new name: "Lager", description: "lager" }
  it "is saved when name, style and brewery are defined" do
    #brewery = Brewery.create name: 'Brewery', year: 1900
    beer = Beer.create name: "iso 3", style: test_style, brewery: test_brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved when name is not defined" do
    beer = Beer.create style: "Lager", style: test_style, brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved when style is not defined" do
    beer = Beer.create name: "Olut", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
