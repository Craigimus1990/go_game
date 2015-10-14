class GameController < ApplicationController

  def show
    @game = Game.find(params[:id])

		@player_name = current_player.nil? ? "[NOT LOGGED IN]" : current_player.name

		@black_player_name = @game.black_player.nil? ? "[OPEN]" : Player.find_by_id(@game.black_player.id).name
		@white_player_name = @game.white_player.nil? ? "[OPEN]" : Player.find_by_id(@game.white_player.id).name
  end

	def get_board
		@game = Game.find(params[:id])

    render json: {:board => @game.board, :turn => @game.turn, :id => params[:id] }
	end

  def create
		if current_player.nil?
			redirect_to 'player/logon'
		else
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

    board = Array.new(@size) { Array.new(@size) }
    board = board.map { |row| row.map { |col| col=0 }}

    @game = Game.new({ :board => board, :turn => 1, :black_player => current_player})
    if @game.save
      redirect_to :action => 'show', :id => @game.id
    else
      render 'failed'
    end
	end

	def select_game
		if (current_player.nil?)
			redirect_to 'player/logon'
		else
			@current_games = (Game.where(:black_player_id => session[:player_id]) + 
												Game.where(:white_player_id => session[:player_id])).uniq.to_a
			@open_games = Game.where(:white_player_id => nil).to_a
		end
	end

	def validate
		@game = Game.find(params[:id])
    move = [params[:x], params[:y]]
	
		id = session[:player_id]

		if @game.turn == 1 and @game.black_player.nil?
			@game.black_player = Player.find_by_id(session[:player_id])
			@game.save
		elsif @game.turn == -1 and @game.white_player.nil?
			@game.white_player = Player.find_by_id(session[:player_id])
			@game.save
		end

		result = Hash.new
		if @game.turn == 1 and id != @game.black_player.id
			player_name = Player.find_by_id(session[:player_id]).name
			result[:msg] = "#{player_name}, it's not your turn!"
			result[:valid] = false
			result[:result] = @game
		elsif @game.turn == -1 and id != @game.white_player.id
			player_name = Player.find_by_id(session[:player_id]).name
			result[:msg] = "#{player_name}, it's not your turn!"
			result[:valid] = false
			result[:result] = @game
		else
    	g = GameEngine.new
    	result = g.check_new_move(*move, @game.turn, @game.board)
		end

		if (result[:valid])
			@game.board = result[:result].board
			@game.turn = @game.turn * -1
			@game.save
		end

    render json: {:board => result[:result].board, :valid => result[:valid], :id => params[:id], :msg => result[:msg].to_s }
  end
end
