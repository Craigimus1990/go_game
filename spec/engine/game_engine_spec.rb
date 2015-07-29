require 'spec_helper'

describe GameEngine do
  
  context 'given a move to (0,1)' do
    before(:each) do
      @engine = GameEngine.new
      @new_move = {"move" => [0,1], "color" => -1}
    end
      
    describe '#remove_dead_enemies' do
      context ' and 1 is vulnerable ' do
        it "removes dead elements from the game" do
          
          board_after_move =Board.new([[1,-1,-1], [-1, 1, -1], [1, -1, 0]]) 
          new_board = @engine.remove_dead_enemies(@new_move, board_after_move)
          expect(new_board.board).to eql [[0,-1,-1], [-1, 0, -1], [0, -1, 0]]
        end
      end
      
      context ' and nothing is vulnerable ' do
        it "nothing happens" do
          
          board_after_move =Board.new([[0,1,0], [-1, 0, 0], [0, 0, 0]]) 
          new_board = @engine.remove_dead_enemies(@new_move, board_after_move)
          expect(new_board.board).to eql [[0,1,0], [-1, 0, 0], [0, 0, 0]]
        end
      end
    end

    context ' and 1 is vulnerable' do
      before :each do
        @board = Board.new([[1,-1,-1], [0, 1, -1], [1, -1, 0]])  
      end
    
      describe "#place_piece" do
        it "places the given piece" do
         new_board = @engine.place_piece(@new_move, @board)
          expect(new_board.board).to eql [[1,-1,-1], [-1, 1, -1], [1, -1, 0]]
        end
      end
      
      describe "#remove_block" do
        it "removes a large block" do
          to_remove = [[1,0],[2,0],[2,1]]
          new_board = @engine.remove_block(@board, to_remove)
          expect(new_board.board).to eql [[1,0,0], [0, 1, 0], [1, -1, 0]]
        end
        
        it "removes a small block" do
          to_remove = [[1,1]]
          new_board = @engine.remove_block(@board, to_remove)
          expect(new_board.board).to eql [[1,-1,-1], [0, 0, -1], [1, -1, 0]]
        end
      end
    end
  end
end