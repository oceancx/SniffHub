class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user?

  helper_method :page

  before_action :require_user

  def current_user
    return @current_user if !@current_user.nil?
    return nil if session[:current_user_id].nil?

    @current_user = User.where(id: session[:current_user_id]).first

    @current_user
  end

  def current_user?
    !current_user.nil?
  end

  def require_user
    if !current_user?
      session[:login_redirect] = request.original_url
      redirect_to('/login')
      return
    end
  end

  def page
    @page ||= {}
  end
end
