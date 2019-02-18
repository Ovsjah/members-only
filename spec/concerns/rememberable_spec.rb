require 'rails_helper'

describe Rememberable, type: :controller do
  include Rememberable
  include SessionsHelper

  let(:user) { create(:user) }
  before(:each) { remember(user) }

  describe 'remember' do
    it "returns remember token" do
      expect(remember(user)).to eq(user.remember_token)
    end

    it "remembers user's id inside the cookies" do
      expect(cookies.signed[:user_id]).to eq(user.to_param.to_i)
    end

    it "remember user's remember token inside the cookies" do
      expect(cookies[:remember_token]).to eq(user.remember_token)
    end
  end

  describe 'forget' do
    before(:each) { forget(user) }

    it "removes user's remember digest" do
      expect(user.remember_digest).to be_nil
    end

    it "removes user's id from cookies" do
      expect(cookies[:user_id]).to be_nil
    end

    it "removes user's remember token from cookies" do
      expect(cookies[:remember_token]).to be_nil
    end
  end
end
