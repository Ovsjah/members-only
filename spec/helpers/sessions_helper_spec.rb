require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  include Signinable
  include Rememberable

  let(:user) { create(:user) }
  before(:each) { sign_in(user) }

  describe 'current_user' do
    context "with singing in" do
      it "returns the current user" do
        expect(current_user).to eq(user)
      end
    end

    context "with remembering" do
      it "returns the current user" do
        sign_out
        remember(user)
        expect(current_user).to eq(user)
      end
    end
  end

  describe 'current_user?' do
    let(:not_signed_in_user) { create(:user) }

    it "returns true if the given user is current user" do
      expect(current_user?(user)).to eq(true)
    end

    it "returns false otherwise" do
      expect(current_user?(not_signed_in_user)).to eq(false)
    end
  end

  describe 'signed_in?' do
    it "returns true if the user is signed in" do
      expect(signed_in?).to eq(true)
    end

    it "returns false otherwise" do
      sign_out
      expect(signed_in?).to eq(false)
    end
  end
end
