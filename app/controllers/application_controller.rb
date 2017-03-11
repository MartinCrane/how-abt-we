class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_accounts

  def logged_in?
    !!session[:account_id]
  end

  def current_user
    Account.find(session[:account_id]) if logged_in?
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def set_accounts
    @accounts = Account.all

  end
end
