class Game < ActiveRecord::Base
  STOCK = [4, 3, 2, 1, 0]

  belongs_to :stage
  validates :player_1_id, presence: true
  validates :player_2_id, presence: true
  validates :player_1_character_id, presence: true
  validates :player_2_character_id, presence: true
  validates :player_1_stock, presence: true
  validates :player_2_stock, presence: true
  validates :stage_id, presence: true
  validates :description, length: { maximum: 500 }

  def has_winner_and_loser?
    if player_1_stock == 0 && player_2_stock == 0
      errors.add(:game, "must have a winner")
      return false
    elsif player_1_stock > 0 && player_2_stock > 0
      errors.add(:game, "must have a loser")
      return false
    else
      return true
    end
  end

  def winner
    if player_1_stock < player_2_stock
      User.find(player_2_id)
    elsif player_1_stock > player_2_stock
      User.find(player_1_id)
    else
      User.first
    end
  end

  def loser
    if player_1_stock < player_2_stock
      User.find(player_1_id)
    elsif player_1_stock > player_2_stock
      User.find(player_2_id)
    else
      User.first
    end
  end

  def players
    p1 = User.find(player_1_id)
    p2 = User.find(player_2_id)
    "#{p1.username} vs. #{p2.username}"
  end

  def player_1
    User.find(player_1_id)
  end

  def player_1_character
    Character.find(player_1_character_id)
  end

  def player_2
    User.find(player_2_id)
  end

  def player_2_character
    Character.find(player_2_character_id)
  end
end
