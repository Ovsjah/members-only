require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Signinable, Rememberable

  let(:user) { create(:user) }
  let(:valid_params) { {user: attributes_for(:user)} }
  let(:invalid_params) { {user: attributes_for(:user).invert} }

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
    context "with valid params" do
      it "creates a user" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid params" do
      before(:each) { post :create, params: invalid_params }
      render_views

      it "doesn't create a user" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        post :create, params: invalid_params
        expect(response).to render_template('new')
      end

      it_behaves_like("has errors")
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: {id: user.to_param}
      expect(response).to render_template('show')
    end
  end

  describe "GET #edit" do
    context "when user is not signed in or remembered" do
      before(:each) { get :edit, params: {id: user.to_param} }
      render_views

      it "redirects edit to sign in action" do
        expect(response.location).to include('/signin')
      end

      it "has the flash error" do
        expect(flash).to be_present
      end
    end

    context "when user is signed in" do
      it_behaves_like("edit action", :sign_in)
    end

    context "when user is remembered" do
      it_behaves_like("edit action", :remember)
    end

    context "when user is not correct" do
      context "when signed in user tries to access the edit page of another user" do
        it_behaves_like("redirected from the edit page", :sign_in)
      end

      context "when remembered user tries to access the edit page of another user" do
        it_behaves_like("redirected from the edit page", :remember)
      end
    end
  end

  describe 'PATCH #update' do
    context "with valid params" do
      context "when user is signed in" do
        it_behaves_like("update action", :sign_in)
      end

      context "when user is remembered" do
        it_behaves_like("update action", :remember)
      end
    end

    context "when user is not correct" do
      context "when signed in user tries to update another user" do
        it_behaves_like("redirected from the update action", :sign_in)
      end

      context "when remembered user tries to update another user" do
        it_behaves_like("redirected from the update action", :remember)
      end
    end

    context "with invalid params" do
      render_views
      let(:new_invalid_params) { {name: Faker::Name.name, email: ""}}

      before(:each) do
        sign_in(user)
        patch :update, params: {id: user.to_param, user: new_invalid_params}
      end

      it "doesn't update user" do
        expect(user.reload.name).not_to eq(new_invalid_params[:name])
      end

      it_behaves_like("has errors")
    end
  end
end
