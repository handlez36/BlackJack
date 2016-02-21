class AddDeckIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :deck_id, :integer
    remove_column :cards, :game_id
  end
end
