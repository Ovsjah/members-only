module SessionsHelper
  def current_user?(user)
    user == current_user
  end

  def current_user
    @current_user ||=
      if (user_id = session[:user_id])
        User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        user if user&.authenticated?(:remember, cookies[:remember_token])
      end
  end

  def signed_in?
    !!current_user
  end
end
