class Game < ActiveRecord::Base
  CHARACTERS = [
    "Dr. Mario", "Mario", "Luigi", "Bowser", "Peach", "Yoshi",
    "Donkey Kong", "Captain Falcon", "Ganondorf", "Falco", "Fox",
    "Ness", "Ice Climbers", "Kirby", "Samus", "Zelda", "Link",
    "Young Link", "Pichu", "Pikachu", "Jigglypuff", "Mewtwo",
    "Mr. Game & Watch", "Marth", "Roy"
  ]
  STOCK = [4, 3, 2, 1, 0]

  belongs_to :stage
  validates :player_1_id, presence: true
  validates :player_2_id, presence: true
  validates :player_1_character_id, presence: true
  validates :player_2_character_id, presence: true
  validates :player_1_stock, presence: true
  validates :player_2_stock, presence: true
  validates :stage_id, presence: true

  def winner
    if player_1_stock < player_2_stock
      User.find(player_2_id)
    elsif player_1_stock > player_2_stock
      User.find(player_1_id)
    end
  end

  def loser
    if player_1_stock < player_2_stock
      User.find(player_1_id)
    elsif player_1_stock > player_2_stock
      User.find(player_2_id)
    end
  end

  def players
    p1 = User.find(player_1_id)
    p2 = User.find(player_2_id)
    "#{p1.username} vs. #{p2.username}"
  end
end
