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

		board.each do |row| {

		}
	end

end
