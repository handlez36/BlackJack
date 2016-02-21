class UpdateDefaultValueForDecks < ActiveRecord::Migration
  def change
    change_column_default :decks, :current_index, -1
  end
end
