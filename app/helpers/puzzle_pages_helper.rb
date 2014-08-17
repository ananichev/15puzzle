module PuzzlePagesHelper

  private
	
    def moving_elements(board, part)
      moving_elem = []
      board = board.flatten
      zero = board.index(0)
      positions(board)
      horizontal_elem(part, board)
      vertical_elem(board) 	
      (moving_elem << board[@upper_elem] << board[@lower_elem] << board[@left_elem] << board[@right_elem]).compact!
      moving_elem
    end
  
    def positions(board)
      zero = board.index(0)
      @left_elem = zero - 1
      @right_elem = zero + 1
      @upper_elem = zero - 4
      @lower_elem = zero + 4
    end
  
    def horizontal_elem(part, board)
      unless part.include? 0
      @left_elem = board.index(0) - 100
      @right_elem = board.index(0) + 100
      end
    end
    
    def vertical_elem(board)
      if @upper_elem < 0
        @upper_elem = board.index(0) + 100
      end
    end
end
