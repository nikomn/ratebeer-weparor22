require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
                                     options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end

    Capybara.javascript_driver = :chrome
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order by default", :js => true do
    visit beerlist_path
    expect(find('#beertable').all('.tablerow')[0]).to have_content "Fastenbier"
    expect(find('#beertable').all('.tablerow')[1]).to have_content "Lechte Weisse"
    expect(find('#beertable').all('.tablerow')[2]).to have_content "Nikolai"
  end

  it "orders beers by style when table heading style clicked", :js => true do
    visit beerlist_path
    find('#style').click
    expect(find('#beertable').all('.tablerow')[0]).to have_content "Nikolai"
    expect(find('#beertable').all('.tablerow')[1]).to have_content "Fastenbier"
    expect(find('#beertable').all('.tablerow')[2]).to have_content "Lechte Weisse"
  end

  it "orders beers by brewery when table heading brewery clicked", :js => true do
    visit beerlist_path
    find('#brewery').click
    expect(find('#beertable').all('.tablerow')[0]).to have_content "Lechte Weisse"
    expect(find('#beertable').all('.tablerow')[1]).to have_content "Nikolai"
    expect(find('#beertable').all('.tablerow')[2]).to have_content "Fastenbier"
  end
end