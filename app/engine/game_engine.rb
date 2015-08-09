class GameEngine
  
  def initialize
    @remove = true
    @keep = false
  end
  
  def check_new_move(x,y, color_placed, raw_board)
    original_board = Board.new(raw_board)
    new_move = { "move" => [x.to_i,y.to_i],
                  "color" => color_placed }
    
    board_after_move = place_piece(new_move, original_board)
    board_after_captures = remove_dead_enemies(new_move, board_after_move)
    
    checker = BlockChecker.new(board_after_captures)
    new_block = checker.calculate_block_from(new_move["move"])
    
    if checker.block_has_liberty?(new_block)
      return board_after_captures #a valid move was made
    else
      return raw_board #an invalid move was made
    end

  end
  
  def place_piece(new_move, original_board)
    new_board = original_board
    new_board.set_color(*new_move["move"], new_move["color"])
    
    return new_board
  end
  
  def remove_dead_enemies(new_move, current_board)
    checker = BlockChecker.new(current_board)
    
    checker.all_neighbors_of(new_move["move"]).each do |neighbor|
      if current_board.is_valid?(*neighbor) && 
            current_board.get_color(*neighbor) * -1 == new_move["color"]
            
        block = checker.calculate_block_from neighbor
        unless checker.block_has_liberty? block
          current_board = remove_block(current_board, block)
        end
      end
    end
    
    return current_board
  end
  
  def remove_block(current_board, block)
    new_board = current_board
    block.each do |point|
      new_board.set_color(*point, 0)
    end
    
    return new_board
  end
end
