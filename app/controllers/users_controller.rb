class UsersController < ApplicationController

  def index
    @users = User.order(wins: :desc)
  end

end
