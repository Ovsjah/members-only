shared_examples "has errors" do
  it "renders full error messages" do
    assigns(:user).errors.full_messages.each do |msg|
      expect(response.body).to have_text(msg)
    end
  end
end

shared_examples "edit action" do |method_name|
  it "renders the edit view" do
    user = create(:user)
    send(method_name, user)
    get :edit, params: {id: user.to_param}
    expect(response).to render_template('edit')
  end
end

shared_examples "redirected from the edit page" do |method_name|
  it "redirects to the home page" do
    send(method_name, create(:user))
    get :edit, params: {id: create(:user).to_param}
    expect(subject).to redirect_to(root_path)
  end
end

shared_examples "update action" do |method_name|
  it "updates the user" do
    new_params = {
      name: "#{Faker::Name.name}"
    }

    user = create(:user)
    send(method_name, user)

    patch :update, params: {id: user.to_param, user: new_params}
    user.reload

    expect(user.name).to eq(new_params[:name])
  end
end

shared_examples "redirected from the update action" do |method_name|
  it "redirects to the home page" do
    another_user_new_params = {
      email: "#{Faker::Internet.email}"
    }

    user = create(:user)
    another_user = create(:user)
    send(method_name, user)

    patch :update, params: {id: another_user.to_param, user: another_user_new_params}

    expect(subject).to redirect_to(root_path)
  end
end
