class RegistrationsController < ApplicationController

  def new
    #sign-up form
    @account=Account.new
  end

  def create
    account=Account.new(account_params)
    if account.valid?
      account.save
      session[:account_id]=account.id
      redirect_to account
    else
      #flash[:error]=account.errors
      redirect_to new_registration_path
    end
    #sign-up creation
  end

  private

  def account_params
    params.require(:account).permit(:username, :email, :password, :password_confirmation)
  end
end