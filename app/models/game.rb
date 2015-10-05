class Game < ActiveRecord::Base
  belongs_to :stage
  validates :player_1_id, presence: true
  validates :player_2_id, presence: true
  validates :player_1_character, presence: true
  validates :player_2_character, presence: true
  validates :player_1_stock, presence: true
  validates :player_2_stock, presence: true
  validates :stage_id, presence: true
end
