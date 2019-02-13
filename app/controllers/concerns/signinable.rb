module Signinable
  include ActiveSupport::Concern

  # Signs in the given user
  def sign_in(user)
    session[:user_id] = user.id
  end

  # Signs out the current user
  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
