class UsersController < ApplicationController
  include Signinable

  before_action :get_user, except: %i[index new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = "Congrats! You're a member now."
      redirect_to @user
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def get_user
      @user = User.find(params[:id])
    end
end
