module PuzzlePagesHelper
	
  def moving_elements(board, part)
  	board = board.flatten
	zero = board.index(0)
  	pos(board)
	
  	unless part.include? 0
  	  @left_elem = zero - 100
  	  @right_elem = zero + 100
  	end
  	
  	moving_elem = []
  	moving_elem << board[@upper_elem] << board[@lower_elem] << board[@left_elem] << board[@right_elem]

  	moving_elem.compact!
  	p moving_elem
  end
  
  def pos(board)
	zero = board.index(0)
  	@left_elem = zero - 1
  	@right_elem = zero + 1
  	@upper_elem = zero - 4
  	@lower_elem = zero + 4
  end
  

end
