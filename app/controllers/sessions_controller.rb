class SessionsController < ApplicationController

  def new
    #login form
    @account=Account.new
  end

  def destroy
    reset_session
    redirect_to "/"
  end

  def create
    #login authentication
    account = Account.find_by(username: login_params[:username])
    if account && account.authenticate(login_params[:password])
      session[:account_id]=account.id
      redirect_to account
    else
      flash[:error]="Something went wrong"
      redirect_to login_path
    end
  end

  private

  def login_params
    params.require(:account).permit(:username, :password)
  end

end
