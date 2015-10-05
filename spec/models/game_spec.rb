require 'rails_helper'

RSpec.describe Game, type: :model do

  it { should validate_presence_of(:player_1_id) }
  it { should validate_presence_of(:player_2_id) }
  it { should validate_presence_of(:player_1_character) }
  it { should validate_presence_of(:player_2_character) }
  it { should validate_presence_of(:player_1_stock) }
  it { should validate_presence_of(:player_2_stock) }
  it { should validate_presence_of(:stage_id) }

  it { should belong_to(:stage) }

end
