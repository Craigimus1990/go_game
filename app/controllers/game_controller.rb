class GameController < ApplicationController

  def show
    @game = Game.find(params[:id])
  end

	def get_board
		@game = Game.find(params[:id])

    render json: {:board => @game.board, :turn => @game.turn, :id => params[:id] }
	end

  def create
		unless session[:player_id].nil?
			player = Player.find_by_id(session[:player_id])
			@default = player.name
		end
  end

	def start_game
    unless params[:size].nil?
      @size = params[:size].to_i
    else
      @size = 9
    end

		player = Player.find_by_name(params[:username])
		
		if player.nil?
			player = Player.create({ :name => params[:username] })
		end

		session[:player_id] = player.id

    board = Array.new(@size) { Array.new(@size) }
    board = board.map { |row| row.map { |col| col=0 }}

    @game = Game.new({ :board => board, :turn => 1, :black_player => player})
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
	
		id = session[:player_id]

		if @game.turn == 1 and id != @game.black_player.id
			render json: { :board => @game.board, :valid => false, :id => params[:id] }
			puts "It is not your turn!!!"
			return
		end
			
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
