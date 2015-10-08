class AddP2ValidationToGames < ActiveRecord::Migration
  def change
    add_column :games, :p2_confirmation, :boolean, default: false
  end
end
