require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { {user: attributes_for(:user)} }
  let(:invalid_attributes) { {user: attributes_for(:user).invert} }

  describe "GET #new" do
    before(:each) { get :new }
    render_views

    it "renders the new template" do
      expect(response).to render_template('new')
    end

    it "renders the form partial" do
      expect(response).to render_template(partial: '_form')
    end

    it "renders the error_messages partial" do
      expect(response).to render_template(partial: "shared/_error_messages")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a user" do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid attributes" do
      before(:each) { post :create, params: invalid_attributes }
      render_views

      it "doesn't create a user" do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        post :create, params: invalid_attributes
        expect(response).to render_template('new')
      end

      it "renders the error messages" do
        assigns(:user).errors.full_messages.each do |msg|
          expect(response.body).to have_text(msg)
        end
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: {id: user.to_param}
      expect(response).to render_template('show')
    end
  end
end
