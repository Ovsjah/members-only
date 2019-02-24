class UsersController < ApplicationController
  include Signinable, Redirectable, SessionsHelper

  before_action :get_user, except: %i[index new create]
  before_action :signed_in_user, except: %i[show new create]
  before_action :correct_user, only: %i[edit update]
  #before_action :admin_user, only: :destroy

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

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render :edit
    end
  end

  #def destroy
    #@user.destroy!
    #flash[:success] = "Not a member anymore!"
    #redirect_to root_path
  #end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Restricted for non members"
        redirect_to signin_path
      end
    end

    def correct_user
      redirect_to root_path unless current_user? @user
    end
end
