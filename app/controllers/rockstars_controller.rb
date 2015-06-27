class RockstarsController < ApplicationController
	def index
		@front_men = [FrontMan.new(1, 'David St. Hubbins'), FrontMan.new(2, 'David Lee Roth')]
	end
end
