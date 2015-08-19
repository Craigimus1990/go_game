class GameController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

  def create
		unless params[:size].nil?
			@size = params[:size].to_i
		else
			@size = 9
		end

		board = Array.new(@size) { Array.new(@size) }
		board = board.map { |row| row.map { |col| col=0 }}		

    @game = Game.new({ :board => board, :turn => 1 })
    if @game.save
      redirect_to :action => 'show', :id => @game.id
    else
      render 'failed'
    end
  end

	def index
		unless params[:size].nil?
			@size = params[:size].to_i
		else 
			@size = 5
		end
	end

	def validate
		@game = Game.find(params[:id])
    move = [params[:x], params[:y]]

    g = GameEngine.new
    result_check = g.check_new_move(*move, @game.turn, @game.board)

		if (result_check[:valid])
			@game.board = result_check[:result].board
			@game.turn = @game.turn * -1
			@game.save
		end

    render json: {:board => result_check[:result].board, :valid => result_check[:valid], :id => params[:id] }
  end
	
end
