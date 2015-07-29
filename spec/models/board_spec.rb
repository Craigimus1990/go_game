require 'spec_helper'

describe Board do
  before :each do
    @board = Board.new([[0,1], [0, -1]])  
  end
  
  describe '#is_valid?' do
    it "should return true if the point is in bounds" do
      expect(@board.is_valid?(0,0)).to eql true
      expect(@board.is_valid?(0,1)).to eql true
      expect(@board.is_valid?(1,0)).to eql true
      expect(@board.is_valid?(1,1)).to eql true
    end
    
    it "should return false if the point is out of bounds" do
      expect(@board.is_valid?(-1,0)).to eql false
      expect(@board.is_valid?(-1,-1)).to eql false
      expect(@board.is_valid?(0,-1)).to eql false
      expect(@board.is_valid?(1,-1)).to eql false
      expect(@board.is_valid?(2,-1)).to eql false
      expect(@board.is_valid?(2,0)).to eql false
      expect(@board.is_valid?(2,1)).to eql false
      expect(@board.is_valid?(2,2)).to eql false
      expect(@board.is_valid?(1,2)).to eql false
      expect(@board.is_valid?(0,2)).to eql false
      expect(@board.is_valid?(-1,2)).to eql false
      expect(@board.is_valid?(-1,1)).to eql false
    end
  end
  
  describe '#get_color' do
    it "should return the correct color" do
       expect(@board.get_color(0,0)).to eql 0
       expect(@board.get_color(1,0)).to eql 1
       expect(@board.get_color(1,1)).to eql(-1)
    end
  end
  
  describe '#set_color' do
    it "should change the color" do
      @board.set_color(0,0,1)
      expect(@board.get_color(0,0)).to eql 1
    end
  end
  
  describe '#colors_match?' do
    it "should return true if the colors match" do
       expect(@board.colors_match?(0,0,0)).to eql true
       expect(@board.colors_match?(1,0,1)).to eql true
       expect(@board.colors_match?(1,1,-1)).to eql true
    end
    
    it "should return false if the colors dont match" do
       expect(@board.colors_match?(0,0,1)).to eql false
       expect(@board.colors_match?(1,0,-1)).to eql false
       expect(@board.colors_match?(1,1,0)).to eql false
    end
  end
end