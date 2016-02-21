class AddTurnToGame < ActiveRecord::Migration
  def change
    add_column :games, :turn_id, :integer, index: true, foreign_key: true
  end
end
