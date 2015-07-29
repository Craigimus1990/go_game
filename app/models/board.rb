class Board
  attr_accessor :board
  
  def initialize(board)
    @board = board
  end
  
  def is_valid?(x,y)
    if x < 0 || y < 0
      return false
    end
    
    #assuming a square board
    if x > @board.size - 1 || y > @board.size - 1
      return false
    end
    return true
  end
  
  def get_color(x, y)
    @board[y][x]
  end
  
  def set_color(x, y, value)
    @board[y][x] = value
  end
  
  def colors_match?(x,y, color)
    get_color(x,y) == color
  end
end