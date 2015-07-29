class BlockChecker
  def initialize(board)
    @board = board
  end
  
  def block_has_liberty?(block)
    for point in block
      if point_has_liberty?(point)
        return true
      end
    end
    return false
  end

  def point_has_liberty?(point)
    if @board.is_valid?(*point)
      all_neighbors_of(point).each do |neighbor|
        if @board.is_valid?(*neighbor) && @board.get_color(*neighbor) == 0
          return true
        end
      end
    end
    return false
  end

  def calculate_block_from(point, block=Set.new([]))
    c = @board.get_color(*point)
    if c == 0 
      return Set.new()
    end
    
    block.add point
    
    all_neighbors_of(point).each do |neighbor|
      if @board.is_valid?(*neighbor) && 
           @board.colors_match?(*neighbor, c) &&
           !block.include?(neighbor)
        block = calculate_block_from(neighbor, block)
      end
    end
    
    return block
  end

  def all_neighbors_of(point)
    [left_of(point), right_of(point), above(point), below(point)]
  end

  def left_of(point)
    [point[0] - 1, point[1]]
  end
  
  def right_of(point)
    [point[0] + 1, point[1]]
  end
  
  def above(point)
    [point[0], point[1] - 1]
  end
  
  def below(point)
    [point[0], point[1] + 1]
  end
end