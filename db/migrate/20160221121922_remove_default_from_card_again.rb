class RemoveDefaultFromCardAgain < ActiveRecord::Migration
  def change
    change_column :cards, :played, :boolean, default: nil
  end
end
