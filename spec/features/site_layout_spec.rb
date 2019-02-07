require 'rails_helper'

RSpec.feature "SiteLayouts", type: :feature do
  include ApplicationHelper

  context "when user isn't logged in" do
    context "when user is at home" do
      before(:each) { visit root_path }

      it "has 2 root links" do
        expect(page).to have_link(href: root_path, count: 2)
      end

      it "has an about link" do
        expect(page).to have_link(href: about_path)
      end

      it "has a contact link" do
        expect(page).to have_link(href: contact_path)
      end

      it "has a wikipedia link" do
        expect(page).to have_link(href: "https://en.wikipedia.org/wiki/David_Cronenberg")
      end

      it "has the Odin link" do
        expect(page).to have_link(href: "https://www.theodinproject.com/dashboard")
      end
    end

    context "when user navigates to the Contact page" do
      it "has a Contact title" do
        visit contact_path
        expect(page).to have_title(full_title('Contact'))
      end
    end

    context "when user navigates to the About page" do
      it "has an About title" do
        visit about_path
        expect(page).to have_title(full_title('About'))
      end
    end
  end
end
