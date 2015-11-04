require 'spec_helper'

describe PlayerController do
	describe "#create" do
		subject { post :create, :player => { :name => "Foo" }}

		it "creates a new player" do
			expect(subject).to redirect_to game_select_game_url
			# pending: expect(subject).to change(Player.count).by(1)
		end
	end

	describe "POST #logon" do
		subject { post :logon, :player_id => 1 }

		it "loads a player" do
			expect(subject).to redirect_to game_select_game_url
			expect(session[:player_id]).to eql 1
		end
	end

	describe "GET #logout" do
		it "logs out the user" do
			get :logout
			expect(session[:player_id]).to be_nil
		end
	end

end
