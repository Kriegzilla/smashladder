class AddStageIcons < ActiveRecord::Migration
  def change
    add_column :stages, :icon, :string, null: false
  end
end
