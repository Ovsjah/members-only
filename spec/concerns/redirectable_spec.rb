require 'rails_helper'

describe Redirectable, type: :controller do
  controller(UsersController) { include Redirectable }
  let(:user) { create(:user) }

  describe 'store_location' do
    before(:each) { get :edit, params: {id: user.to_param} }

    it "returns the desired location" do
      expect(subject.store_location).to include(edit_user_path(user))
    end

    it "stores desired location in the session" do
      subject.store_location
      expect(session[:forwarding_url]).to include(edit_user_path(user))
    end
  end

  describe 'redirect_back_or_to' do
    it { expect(subject).to respond_to(:redirect_back_or_to) }
  end
end
