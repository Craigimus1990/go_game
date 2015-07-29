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
    offense_color = params[:color] == "black" ? -1 : 1
    move = [params[:x], params[:y]]
    
    g = GameEngine.new
    new_board = g.check_new_move(*move, offense_color, board)

    puts new_board.inspect
    return new_board
  end
	
end
