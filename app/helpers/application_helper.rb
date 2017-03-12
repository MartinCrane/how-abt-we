module ApplicationHelper

  def logged_in?
    !!session[:account_id]
  end

  def current_user
    Account.find(session[:account_id]) if logged_in?
  end
  
end
