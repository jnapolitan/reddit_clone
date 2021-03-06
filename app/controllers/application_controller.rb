class ApplicationController < ActionController::Base

  helper_method :current_user, :signed_in?

  private

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def login(user)
    @current_user = user
    session[:token] = user.reset_session_token!
    redirect_to subs_url
  end

  def logout
    if current_user
      current_user.reset_session_token!
      session[:token] = nil
    end
    redirect_to new_session_url
  end

  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

  def require_signed_out!
    redirect_to user_url(current_user) if signed_in?
  end
  
end
