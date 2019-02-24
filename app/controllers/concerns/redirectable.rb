module Redirectable
  include ActiveSupport::Concern

  def redirect_back_or_to(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:frowarding_url)
  end

  def store_location
    session[:forwarding_url] = request&.original_url if request&.get?
  end
end
