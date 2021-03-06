class SessionsController < ApplicationController
  include Signinable, Rememberable, Redirectable, SessionsHelper
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user&.authenticate(params[:session][:password])
      params[:session][:remember_me] == '1' ? remember(@user) : sign_in(@user)
      flash[:success] = "What's up bro?"
      redirect_back_or_to @user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    if remembered?
      forget(current_user)
    else
      sign_out
    end

    redirect_to root_url
  end
end
