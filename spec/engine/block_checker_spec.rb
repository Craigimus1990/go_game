require 'spec_helper'

describe BlockChecker do
  describe '#block_has_liberty' do
    it "should return the whole block from any point" do
      board = get_board
      checker = BlockChecker.new(board)
      
      expect(checker.block_has_liberty?(get_block_1)).to eql false
      expect(checker.block_has_liberty?(get_block_2)).to eql true
    end
    
    def get_board
      Board.new([[1,1,1], [-1,1,-1], [-1,-1,0]])
    end
    
    def get_block_1
      Set.new([[0,0], [1,0], [2,0], [1,1]])
    end
    
    def get_block_2
      Set.new([[0,1], [0,2], [1,2]])
    end
  end
  
  describe '#calculate_block_from' do
    it "should return the whole block from any point" do
      board = get_board
      checker = BlockChecker.new(board)
      
      expect(checker.calculate_block_from([0,0])).to eql expected_result
      expect(checker.calculate_block_from([1,0])).to eql expected_result
      expect(checker.calculate_block_from([2,0])).to eql expected_result
      expect(checker.calculate_block_from([1,1])).to eql expected_result
      
      expect(checker.calculate_block_from([0,2])).to eql Set.new([[0,2]])
      expect(checker.calculate_block_from([2,2])).to eql Set.new([[2,2]])
    end
    
    it "should return a blank set on unplayed locations" do
      board = get_board
      checker = BlockChecker.new(board)
      
      expect(checker.calculate_block_from([0,1])).to eql Set.new([])
      expect(checker.calculate_block_from([1,2])).to eql Set.new([])
      expect(checker.calculate_block_from([2,1])).to eql Set.new([])
    end
    
    def get_board
      Board.new([[1,1,1], [0,1,0], [-1,0,1]])
    end
    
    def expected_result
      Set.new([[0,0], [1,0], [2,0], [1,1]])
    end
  end
  
  describe '#point_has_liberty?' do
    it "should return true if it has a liberty in the corner" do
      board = Board.new([[0,0,0], [0,0,1], [0,0,0]])
      checker = BlockChecker.new(board)
      
      expect(checker.point_has_liberty?([0,0])).to eql true
      expect(checker.point_has_liberty?([2,2])).to eql true
    end
    
    it "should return false if it has no liberties in the corner" do
      board = Board.new([[0,1], [-1,0]])
      checker = BlockChecker.new(board)
      
      expect(checker.point_has_liberty?([0,0])).to eql false
      expect(checker.point_has_liberty?([1,1])).to eql false
    end
    
    it "should return true if it has liberties on the side" do
      board = Board.new([[0,0,1], [0,0,0], [0,0,1]])
      checker = BlockChecker.new(board)
      
      expect(checker.point_has_liberty?([1,0])).to eql true
      expect(checker.point_has_liberty?([0,1])).to eql true
      expect(checker.point_has_liberty?([1,2])).to eql true
      expect(checker.point_has_liberty?([2,1])).to eql true
    end
    
    it "should return false if it has no liberties on the side" do
      board = Board.new([[-1,0,1], [0,1,0], [-1,0,1]])
      checker = BlockChecker.new(board)
      
      expect(checker.point_has_liberty?([1,0])).to eql false
      expect(checker.point_has_liberty?([0,1])).to eql false
      expect(checker.point_has_liberty?([1,2])).to eql false
      expect(checker.point_has_liberty?([2,1])).to eql false
    end
    
    it "should return true if it has liberties in the middle" do
      board1 = Board.new([[0,0,0], [0,0,0], [0,0,0]])
      checker1 = BlockChecker.new(board1)
      board2 = Board.new([[0,1,0], [1,0,1], [0,0,0]])
      checker2 = BlockChecker.new(board2)
      board3 = Board.new([[0,1,0], [0,0,1], [0,1,0]])
      checker3 = BlockChecker.new(board3)
      board4 = Board.new([[0,0,0], [1,0,1], [0,1,0]])
      checker4 = BlockChecker.new(board4)
      board5 = Board.new([[1,0,0], [1,0,0], [0,1,0]])
      checker5 = BlockChecker.new(board5)
      
      expect(checker1.point_has_liberty?([1,1])).to eql true
      expect(checker2.point_has_liberty?([1,1])).to eql true
      expect(checker3.point_has_liberty?([1,1])).to eql true
      expect(checker4.point_has_liberty?([1,1])).to eql true
      expect(checker5.point_has_liberty?([1,1])).to eql true
    end
    
    it "should return false if it has no liberties on the side" do
      board = Board.new([[0,1,0], [1,0,1], [0,1,0]])
      checker = BlockChecker.new(board)
      
      expect(checker.point_has_liberty?([1,1])).to eql false
    end
  end
end