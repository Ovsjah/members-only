require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include Signinable
  include SessionsHelper

  let(:user) { create(:user) }

  describe "GET #new" do
    it "renders the new view" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    render_views

    let(:valid_params) { {email: user.email, password: user.password} }
    let(:invalid_params) { {email: '', password: '' } }

    context "with valid params" do
      before(:each) { post :create, params: {session: valid_params} }

      it "signs in the user" do
        expect(signed_in?).to be true
      end

      it "redirects to the show view" do
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      before(:each) { post :create, params: {session: invalid_params} }

      it "has a message inside the flash hash" do
        expect(flash).to be_present
      end

      it "renders the new view" do
        expect(response).to render_template('new')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      sign_in(user)
      delete :destroy, params: {id: user.to_param}
    end

    it "deletes the user's session" do
      expect(session).to be_empty
    end

    it "removes the current user" do
      expect(current_user).to be_nil
    end

    it "redirects to the home page" do
      expect(response).to redirect_to(root_path)
    end
  end
end
