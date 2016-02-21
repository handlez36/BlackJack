class AddDefaultPlayedInCard < ActiveRecord::Migration
  def change
    change_column_default :cards, :played, false
  end
end
