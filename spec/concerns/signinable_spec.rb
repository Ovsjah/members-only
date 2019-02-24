require 'rails_helper'

describe Signinable, type: :controller do
  include Signinable
  include SessionsHelper

  let(:user) { create(:user) }
  before(:each) { sign_in(user) }

  describe 'sign_in' do
    it "returns user's id" do
      expect(sign_in(user)).to eq(user.to_param.to_i)
    end

    it "signs in user into the session" do
      expect(session[:user_id]).to eq(user.to_param.to_i)
    end
  end

  describe 'sign_out' do
    before(:each) { sign_out }

    it { expect(sign_out).to be_nil }

    it "removes user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "removes current user" do
      expect(current_user).to be_nil
    end
  end
end
