class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :username, presence: true, length: { maximum: 20 }

  def games
    Game.find(:conditions => ["player_1_id = ? OR player_2_id = ?", id, id])
  end
end
