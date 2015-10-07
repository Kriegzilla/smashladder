class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_1_id, null: false
      t.integer :player_2_id, null: false
      t.integer :player_1_character_id, null: false
      t.integer :player_2_character_id, null: false
      t.integer :stage_id, null: false
      t.integer :player_1_stock, null: false
      t.integer :player_2_stock, null: false
    end
  end
end
