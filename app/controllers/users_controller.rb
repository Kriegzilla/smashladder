class UsersController < ApplicationController

  def index
    @users = User.order(wins: :desc, losses: :asc)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    respond_to do |format|
      format.html
      format.json do
        rivals = @user.rivals
        rival_names = []
        rival_wins = []
        rivals.each do |rival|
          rival_names << rival[0]
          rival_wins << rival[1]
        end
        render json: [rival_names, rival_wins]
      end
    end
  end

end
