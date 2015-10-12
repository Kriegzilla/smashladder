class UsersController < ApplicationController

  def index
    @users = User.order(wins: :desc, losses: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

end
