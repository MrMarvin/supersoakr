class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_before_action :verify_authenticity_token,  only: [:new, :create]

  def new
    redirect_to '/sso/saml'
  end

  def create
    auth = request.env["omniauth.auth"]
    reset_session
    session[:uid] = auth.uid
    session[:expires_at] = Time.current + 24.hours
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
