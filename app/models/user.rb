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

  def rival
    # find who you've lost to the most
    player_games = games
    player_games.where("loser = ?", self)
  end
end
