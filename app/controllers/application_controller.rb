class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_setting, :redirect_to_login, :find_current_user

  private
  def find_current_user
    if session[:user_token].nil? or (@current_user = @setting.users.where(token: session[:user_token]).first).nil?
      redirect_to login_url
    end
  end

  def find_setting
    @setting = Setting.find_or_create_by(domain: request.host)
  end

  def redirect_to_login
    if @setting.nil? or (@setting.routes.empty? or @setting.pages.empty?)
      redirect_to login_url
    end    
  end

  def find_pages
    @pages = @setting.pages.all
  end
end
