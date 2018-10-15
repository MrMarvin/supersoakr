class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user

  private
    def current_user
      if session[:uid] and session[:expires_at] and session[:expires_at] > Time.current
        @current_user ||= User.new()
        @current_user.uid = session[:uid]

        @current_user
      else
        nil
      end
    end


  def authenticate_user!
    return if Rails.env == 'development'

    if !current_user
      redirect_to sso_signin_url, :alert => 'You need to sign in for access to this page.'
    end
  end
end
