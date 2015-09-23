class PlayerController < ApplicationController
	def logon
		player = Player.find_by_name(params[:username])

		unless player.nil?
			session[:player_id] = player.id 
		end
	end

end
