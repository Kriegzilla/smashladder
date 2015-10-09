class GamesController < ApplicationController
  def index
    @games = Game.all.where(p2_confirmation: true).reverse
  end

  def show
    @game = Game.find(params[:id])
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
      flash[:success] = "Game saved!"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join(", ")
      render :new
    end
  end

  def pending_games
    @games = current_user.games.where(p2_confirmation: false).reverse
  end

  def approve
    @game = Game.find(params[:game_id])
    if current_user == @game.player_2
      @game.p2_confirmation = true
      @game.save
      p1 = User.find(@game.player_1_id)
      p2 = current_user
      if @game.winner == p1
        p1.wins += 1
        p2.losses += 1
      else
        p1.losses += 1
        p2.wins += 1
      end
      p1.save
      p2.save
      rank_adjust
      flash[:success] = "Game Approved!"
    end
    redirect_to users_path
  end

  def destroy
    @game = Game.find(params[:id])
    if signed_in? && (current_user == @game.player_2 || current_user == @game.player_1)
      @game.destroy
      rank_adjust
      flash[:success] = 'Game deleted successfully!'
      redirect_to users_path
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = "Stop trying to delete things that aren't yours!"
      redirect_to game_path(@game)
    end
  end

  protected

  def game_params
    params.require(:game).permit(
      :player_2_id,
      :player_1_character_id,
      :player_2_character_id,
      :player_1_stock,
      :player_2_stock,
      :stage_id,
      :description
      )
  end

  def rank_adjust
    users = User.order(wins: :desc, losses: :asc)
    users.each_with_index do |user, index|
      user.rank = index + 1
      user.save
    end
  end
end
