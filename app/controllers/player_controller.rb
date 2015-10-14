class PlayerController < ApplicationController
	def new
		@player = Player.new
	end

	def create
		@player = Player.new({:name => params[:player][:name]})

		if @player.save
			session[:player_id] = @player.id
			redirect_to game_select_game_path
		else
			flash.notice = "Was unable to save player!!"
			render "new"
		end
		
	end

	def show

	end

	def logon
		player = Player.find_by_id(params[:player_id])

		unless player.nil?
			session[:player_id] = player.id 
			redirect_to game_select_game_path
		end
	end

	def logout
		session[:player_id] = nil
	end

end
