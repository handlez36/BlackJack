class AddCurrentIndexToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :current_index, :integer, default: 0
  end
end
