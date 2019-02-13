require 'rails_helper'

RSpec.feature "UsersSignins", type: :feature do
  before(:each) do
    visit root_path
    click_link "Sign in"
  end

  context "with valid singin information followed by signout" do
    let(:user) { create(:user) }

    before(:each) do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button "Sign in"
    end

    it "signs in the user" do
      expect(page).to have_text(user.name)
    end

    context "when user signs out" do
      before(:each) { click_link "Sign out" }

      it "signs out the user" do
        expect(page).to have_link("Sign in")
      end

      it "displays the home page" do
        expect(page).to have_link("Become a member!")
      end
    end
  end

  context "with invalid singin information" do
    before(:each) { click_button "Sign in" }

    it "displays error message" do
      expect(page).to have_text("Invalid email/password combination")
    end

    it "displays the sigin page" do
      expect(page).to have_button("Sign in")
    end
  end
end
