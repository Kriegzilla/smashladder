class UsersController < ApplicationController

  def index
    @users = User.order(wins: :desc, losses: :asc)
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @games = @user.games
    respond_to do |format|
      format.html
      format.json do
        players = @users.map{ |user| user.username }
        wins = @users.map{ |user| user.wins }
        render json: [players, wins]
      end
    end
  end

end
