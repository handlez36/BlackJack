class ChangeCardReferenceInCard < ActiveRecord::Migration
  def change
    remove_column :cards, :user_id
    add_column :cards, :game_id, :integer
  end
end
