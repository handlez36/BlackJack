class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.decimal :current_bet

      t.timestamps null: false
    end
  end
end
