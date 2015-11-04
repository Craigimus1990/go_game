require 'spec_helper'

describe GameController do
	describe "#show" do
		it "shows the specified game" do
			get :show, :id => 1

			check_game
			expect(assigns(:player_name)).to eql "[NOT LOGGED IN]"
			expect(assigns(:black_player_name)).to eql "Player_1"
			expect(assigns(:white_player_name)).to eql "Player_2"
		end
	end

	describe "#get_board" do
		it "gets the board" do
			get :get_board, :id => 1
			expected = { "board" => [], "turn" => 1, "id" => "1" }
			check_game
			expect(JSON.parse(response.body)).to eql expected
		end
	end

	describe "#create" do
		it "finds the current player" do
			get :create, {}, { 'player_id' => 1 }
			expect(assigns(:default)).to eql "Player_1"
		end
	end

	describe "#start_game" do
		subject { get :start_game, {}, { 'player_id' => 1 } }

		it "begins a new game" do
			subject
			expect(assigns(:game).black_player_id).to eql 1
			expect(assigns(:game).id).to eql 2
			expect(assigns(:game).turn).to eql 1

		end

		it "redirects to the display page" do
      expect(subject).to redirect_to game_show_url :id => 3
		end
	end

	describe "#selct_game" do
		it "should provide games the player is in" do
			get :select_game, {}, { 'player_id' => 1}
			expect(assigns(:current_games).length).to eql 1
			expect(assigns(:current_games)[0].black_player_id).to eql 1
			expect(assigns(:current_games)[0].white_player_id).to eql 2
			expect(assigns(:current_games)[0].id).to eql 1
			expect(assigns(:open_games)).to eql []
		end
	end

	describe "#validate" do
		#pending
	end

	def check_game
			expect(assigns(:game).black_player_id).to eql 1
			expect(assigns(:game).white_player_id).to eql 2
			expect(assigns(:game).id).to eql 1
	end
end
