class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.string :type, null: false
    end
    add_index(:stages, :name, unique: true)
  end
end
