class RegistrationsController < ApplicationController

  def new
    #sign-up form
    @account=Account.new
    respond_to :html, :js
  end

  def create
    account=Account.new(account_params)
    if account.valid?
      account.save
      session[:account_id]=account.id
      redirect_to account
    else
      flash[:error]=account.errors.full_messages[0]
      redirect_to root_path
    end
    #sign-up creation
  end

  private

  def account_params
    params.require(:account).permit(:username, :email, :password, :password_confirmation)
  end
end
