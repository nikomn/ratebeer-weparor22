require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "shows only users own ratings" do
    user = FactoryBot.create(:user, username: "First user")
    user2 = FactoryBot.create(:user, username: "Other user")
    FactoryBot.create(:rating, score: 10, user: user)
    FactoryBot.create(:rating, score: 12, user: user)
    FactoryBot.create(:rating, score: 14, user: user)
    FactoryBot.create(:rating, score: 16, user: user2)
    visit user_path(user)
    expect(page).to have_content "This user has made 3 ratings with an average of 12.0"
    expect(page).to have_content "anonymous 10"
    expect(page).to have_content "anonymous 12"
    expect(page).to have_content "anonymous 14"
    expect(page).not_to have_content "anonymous 16"
    visit user_path(user2)
    expect(page).to have_content "This user has made 1 rating with an average of 16.0"
    expect(page).not_to have_content "anonymous 10"
    expect(page).not_to have_content "anonymous 12"
    expect(page).not_to have_content "anonymous 14"
    expect(page).to have_content "anonymous 16"
  end

  it "clicking on delete link deletes rating from database" do
    user = FactoryBot.create(:user, username: "First user")
    FactoryBot.create(:rating, score: 10, user: user)
    sign_in(username: "First user", password: "Foobar1")
    visit user_path(user)
    expect(page).to have_content "This user has made 1 rating with an average of 10.0"
    expect(page).to have_content "anonymous 10"
    expect{
      click_link "Delete"
    }.to change{Rating.count}.from(1).to(0)
    expect(page).not_to have_content "This user has made 1 rating with an average of 10.0"
    expect(page).not_to have_content "anonymous 10"
  end
end