class GameDirector
  
  def initialize
    @remove = true
    @keep = false
  end
  
  def calculate_new_state(board, defender_color) 
    @board = board
    @ret_board = Array.new(@board.size) { |i| Array.new(@board.size) { |i| 0 }}
    
    (0..@board.size - 1).each do |x|
      (0..@board.size - 1).each do |y|
        if (@board[x][y] == defender_color and @ret_board[x][y] == 0) 
          check_neighbors(x,y)
        elsif @board[x][y] == defender_color * -1
          @ret_board[x][y] == defender_color * -1
        end
      end
    end
    
    puts "New state:"
    puts @ret_board.inspect
    @ret_board
  end
  
  def check_neighbors(x,y)
    val = @board[x][y]
    result = @remove
    to_check = []
    checked = []
    to_check.push([x,y]) 
    
    while (not to_check.empty?)
      checking = to_check.shift  
      x = checking[0]
      y = checking[1]
      
      result_right = check_right_neighbor(x,y, to_check)
      result_top = check_top_neighbor(x,y, to_check)
      result_left = check_left_neighbor(x,y, to_check)
      result_bottom = check_bottom_neighbor(x,y, to_check)
      
      result = (result and result_right and result_top and result_left and result_bottom)
      
      checked.push(checking)
    end
    
    if result == @remove
      val = 0
    end

    checked.each do |setx, sety|
      puts "Setting #{setx}, #{sety} to #{val}"
      @ret_board[setx][sety] = val
    end
    
  end
  
  def check_right_neighbor(x,y, to_check_stack)
    val = @board[x][y]

    if x + 1 >= @board.size
      return @remove
    else
      perform_check(x+1, y, val, to_check_stack)
    end
  end
  
  def check_top_neighbor(x,y, to_check_stack)
    val = @board[x][y]

    if y - 1 < 0
      return @remove
    else
      perform_check(x, y-1, val, to_check_stack)
    end
  end
  
  def check_left_neighbor(x,y, to_check_stack)
    val = @board[x][y]
    
    if x - 1 < 0
      return @remove
    else
      perform_check(x-1, y, val, to_check_stack)
    end
  end
  
  def check_bottom_neighbor(x,y, to_check_stack)
    val = @board[x][y]
    
    if y + 1 >= @board.size
      return @remove
    else
      perform_check(x, y+1, val, to_check_stack)
    end
  end
  
  def perform_check(x,y, original_val, to_check_stack)
    if original_val == @board[x][y]
      to_check_stack.push([x,y]) 
      return @remove
    elsif @board[x][y] == 0
      return @keep
    else 
      return @remove
    end
  end
  
end