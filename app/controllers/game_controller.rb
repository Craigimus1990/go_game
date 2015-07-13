class GameController < ApplicationController

	def index
		unless params[:size].nil?
			@size = params[:size].to_i
		else 
			@size = 5
		end
	end

	def validate
		board = params[:board]
    defender_color = params[:color] == "black" ? 1 : -1
    offense_color = defender_color * -1
    
    puts params[:color]
    puts defender_color
    
    g = GameDirector.new
    board_defenders_removed = g.calculate_new_state(board, defender_color)
    new_board = g.calculate_new_state(board_defenders_removed, offense_color)
    
    puts "new board:"
    puts new_board.inspect
    return new_board
  end
	
end
