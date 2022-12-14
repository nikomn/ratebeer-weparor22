require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if API returns multiple, all are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kahjo").and_return(
      [ Place.new( name: "Living room", id: 1 ),
        Place.new( name: "Beerhouse", id: 2 ),
        Place.new( name: "Beer garden", id: 3 )
      ]
    )

    visit places_path
    fill_in('city', with: 'kahjo')
    click_button "Search"

    expect(page).to have_content "Living room"
    expect(page).to have_content "Beerhouse"
    expect(page).to have_content "Beer garden"
  end

  it "if API returns none, error message is shown on page" do
    allow(BeermappingApi).to receive(:places_in).with("unknown").and_return([])

    visit places_path
    fill_in('city', with: 'unknown')
    click_button "Search"

    expect(page).to have_content "No locations in unknown"
  end
end