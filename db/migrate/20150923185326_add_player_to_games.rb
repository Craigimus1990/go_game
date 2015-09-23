class AddPlayerToGames < ActiveRecord::Migration
  def change
    add_reference :games, :black_player, references: :players
		add_reference :games, :white_player, references: :players
  end
end
