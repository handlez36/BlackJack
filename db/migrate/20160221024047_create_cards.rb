class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|      
      t.integer :color
      t.integer :suit
      t.integer :raw_value
      t.integer :card_value
      
      t.timestamps null: false
    end
  end
end
