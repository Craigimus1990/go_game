class ChangeNameForPlayers < ActiveRecord::Migration
  def change
		add_index :players, :name, :unique => true
  end
end
