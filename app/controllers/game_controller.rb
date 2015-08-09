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
    offense_color = params[:color]
    move = [params[:x], params[:y]]
    
		puts "Board: " + board.to_s
		puts "Color: " + offense_color.to_s
		puts "Move: " + move.to_s

    g = GameEngine.new
    new_board = g.check_new_move(*move, offense_color, board)

    puts "Result: #{new_board.board.inspect}"
    render json: {:board => new_board.board }
  end
	
end
