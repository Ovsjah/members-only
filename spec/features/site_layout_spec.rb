require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  include ApplicationHelper

  context "when user isn't logged in" do
    before(:each) { visit root_path }
    
    context "when user is at home" do
      it "has Members Only link" do
        expect(page).to have_link(text: "MEMBERS ONLY")
      end

      it "has Home link" do
        expect(page).to have_link(text: "Home")
      end

      it "has an About link" do
        expect(page).to have_link(text: "About")
      end

      it "has a Contact link" do
        expect(page).to have_link(text: "Contact")
      end

      it "has a wikipedia link" do
        expect(page).to have_link(href: "https://en.wikipedia.org/wiki/David_Cronenberg")
      end

      it "has the Odin link" do
        expect(page).to have_link(text: "Odin")
      end

      it "has the Ovsjah Schweinefresser link" do
        expect(page).to have_link(text: "Ovsjah Schweinefresser")
      end

      it "has a `Become a member!` link" do
        expect(page).to have_link(text: "Become a member!")
      end
    end

    context "when user navigates to the Contact page" do
      it "has a Contact title" do
        click_link "Contact"
        expect(page).to have_title(full_title('Contact'))
      end
    end

    context "when user navigates to the About page" do
      it "has an About title" do
        click_link "About"
        expect(page).to have_title(full_title('About'))
      end
    end

    context "when user navigates to the Home page" do
      it "has a Home title" do
        click_link "Home"
        expect(page).to have_title(full_title)
      end
    end
  end
end
