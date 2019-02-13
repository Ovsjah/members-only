module SessionsHelper
  # Returns true if the given user is the current user, false otherwise
  def current_user?(user)
    user == current_user
  end

  # Returns the current signed-in user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # Returns true if the user is signed in, false otherwise
  def signed_in?
    !current_user.nil?
  end
end
