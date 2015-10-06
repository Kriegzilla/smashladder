class GamesController < ApplicationController
  def new
    @game = Game.new
    @users = User.where.not(id: current_user.id)
    @stages = Stage.all
  end

  def create
    @game = Game.new(game_params)
    @game.player_1_id = current_user.id
    @users = User.where.not(id: current_user.id)
    @stages = Stage.all
    if @game.save
      flash[:success] = "Game saved!"
      redirect_to users_path
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
