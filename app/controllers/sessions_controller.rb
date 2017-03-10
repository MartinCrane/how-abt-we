class SessionsController < ApplicationController

  def new
    #login form
    @account=Account.new
  end

  def create
    #login authentication
    account = Account.find_by(username: login_params[:username])
    if account.authenticate(login_params[:password])
      session[:account_id]=account.id
      redirect_to account
    else
      redirect_to login_path
    end
  end

  def destroy
    #log out

    reset_session
    redirect_to "/"
  end

  private

  def login_params
    params.require(:account).permit(:username, :password)
  end

end
