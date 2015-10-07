class GamesController < ApplicationController
  def index
    @games = Game.all.reverse
  end

  def new
    if signed_in?
      @game = Game.new
      @users = User.where.not(id: current_user.id)
      @stages = Stage.all
    else
      authenticate_user!
    end
  end

  def create
    @game = Game.new(game_params)
    @game.player_1_id = current_user.id
    @users = User.where.not(id: current_user.id)
    @stages = Stage.all
    if @game.save
      p1 = current_user
      p2 = User.find(@game.player_2_id)
      if @game.winner == p1
        p1.wins += 1
        p2.losses += 1
      else
        p1.losses += 1
        p2.wins += 1
      end
      p1.save
      p2.save
      flash[:success] = "Game saved!"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join(", ")
      render :new
    end
  end

  protected

  def game_params
    params.require(:game).permit(
      :player_2_id,
      :player_1_character,
      :player_2_character,
      :player_1_stock,
      :player_2_stock,
      :stage_id
      )
  end
end
