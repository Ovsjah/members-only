require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  before(:each) do
    visit root_path
    click_link "Become a member!"
  end

  context "with valid signup information" do
    let(:password) { Faker::Internet.password }
    let(:valid_attributes) {
      {name: Faker::Name.name, email: Faker::Internet.email,
       password: password, password_confirmation: password}
    }

    it "signs up a user" do
      fill_in 'Name', with: valid_attributes[:name]
      fill_in 'Email', with: valid_attributes[:email]
      fill_in 'Password', with: valid_attributes[:password]
      fill_in "Password confirmation", with: valid_attributes[:password_confirmation]
      click_button "Become a member"

      expect(page).to have_text("Congrats! You're a member now.")
    end
  end

  context "with invalid signup information" do
    before(:each) { click_button "Become a member" }

    it "displays the error messages" do
      expect(page).to have_text("The form contains 4 errors")
    end

    it "displays the signup page" do
      expect(page).to have_button("Become a member")
    end
  end
end
