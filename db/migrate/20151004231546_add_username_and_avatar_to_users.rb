class AddUsernameAndAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :avatar, :string, null: false,
      default: "http://www.ssbwiki.com/images/c/c2/SmashBrosSymbol.svg"
    add_column :users, :crew_tag, :string
    add_column :users, :wins, :integer, null: false, default: 0
    add_column :users, :losses, :integer, null: false, default: 0
    add_column :users, :character, :integer
  end
end
