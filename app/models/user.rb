class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :username, presence: true, length: { maximum: 20 }

  belongs_to :character

  def games
    Game.where("player_1_id = ? OR player_2_id = ?", id, id)
  end

  def rivals
    player_games = games
    lost_games = []
    rivals = {}
    player_games.each do |game|
      if game.loser == self
        lost_games << game
      end
    end
    lost_games.each do |game|
      if rivals.has_key?(game.winner.username)
        rivals[game.winner.username] += 1
      else
        rivals[game.winner.username] = 1
      end
    end
    if rivals == {}
      rivals = {"n/a" => 0}
    else
      rivals = rivals.sort{|a,b| b[1] <=> a[1]}
    end
  end

  def nemesis
    if rivals == {"n/a" => 0}
      nemesis = ["Undefeated!", 0]
    else
      nemesis = rivals.sort{|a,b| b[1] <=> a[1]}.first
    end
  end
end
