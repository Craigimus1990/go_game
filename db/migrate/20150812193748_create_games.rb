class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.binary :board
      t.integer :turn

      t.timestamps null: false
    end
  end
end
