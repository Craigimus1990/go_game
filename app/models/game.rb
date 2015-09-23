class Game < ActiveRecord::Base
	serialize :board
	belongs_to :black_player, class_name: "Player"
	belongs_to :white_player, class_name: "Player"
end
