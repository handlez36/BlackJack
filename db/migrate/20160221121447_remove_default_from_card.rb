class RemoveDefaultFromCard < ActiveRecord::Migration
  def change
    change_column :cards, :played, :boolean
  end
end
