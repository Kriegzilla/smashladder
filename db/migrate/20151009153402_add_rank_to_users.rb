class AddRankToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rank, :integer, null: false, default: 9001
  end
end
