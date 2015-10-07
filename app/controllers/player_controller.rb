class PlayerController < ApplicationController
	def new
		player = Player.find_by_name(params[:username])

		if player.nil?
			player = Player.create({ :name => params[:username] })
			session[:player_id] = player.id 
		else
			flash.notice = "Username #{params[:username]} already exists!"
		end
	end

	def logon
		player = Player.find_by_id(params[:player_id])
		flash.notice = ""

		unless player.nil?
			session[:player_id] = player.id 
			flash.notice = "Currently logged in as #{player.name}"
		end
	end

end
