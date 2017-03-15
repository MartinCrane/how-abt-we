class AccountsController < ApplicationController
  before_action :require_login
  before_action :set_account

  def show
    @events=Event.where(creator: @account)
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end
end
