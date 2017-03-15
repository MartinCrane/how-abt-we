class StaticController < ApplicationController

  def home
    @account=Account.new
    if logged_in?
      redirect_to current_user
    end
  end
end
