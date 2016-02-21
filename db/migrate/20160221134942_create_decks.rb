class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.integer :game_id
      
      t.timestamps null: false
    end
  end
end
