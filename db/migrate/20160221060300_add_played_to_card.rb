class AddPlayedToCard < ActiveRecord::Migration
  def change
    add_column :cards, :played, :boolean
  end
end
