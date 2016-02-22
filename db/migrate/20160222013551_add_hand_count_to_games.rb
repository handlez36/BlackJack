class AddHandCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :hand_count, :integer, default: 0
  end
end
