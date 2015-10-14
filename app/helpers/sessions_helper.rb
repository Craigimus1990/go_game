module SessionsHelper
	def log_in(player)
		session[:player_id] = player.id
	end

	def current_player
		@current_player ||= Player.find_by(id: session[:player_id])
	end

	def logged_in?
		!current_player.nil?
	end
end
