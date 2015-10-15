class UsersController < ApplicationController

  def index
    @users = User.order(wins: :desc, losses: :asc)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    @best_character = @user.best_character
    @wins_with_best = @user.won_with(@best_character).length
    respond_to do |format|
      format.html
      format.json do
        wins_and_losses = @user.wins_and_losses
        opponent_names = []
        wins_against = []
        losses_against = []
        most_played = []
        wins_with = []
        most_played_names = []
        wins_and_losses.each do |player|
          opponent_names << player[0]
          wins_against << player[1]
          losses_against << -player[2]
        end
        @user.most_played_characters.each do |chara|
          most_played << chara[0]
        end
        most_played.each do |chara|
          most_played_names << chara.name
          wins_with << @user.won_with(chara).length
        end
        render json: [opponent_names,
                      wins_against,
                      losses_against,
                      most_played_names,
                      wins_with
                     ]
      end
    end
  end

end
