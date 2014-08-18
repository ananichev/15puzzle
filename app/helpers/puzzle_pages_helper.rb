module PuzzlePagesHelper

  private
	
    def moving_elements(board, part)
      board = board.flatten
      zero = board.index(0)
      upper_elem = [board[zero - 4], board[zero - 8], board[zero - 12]].each { |e| e < 0 ? nil : e }
      lower_elem = [board[zero + 4], board[zero + 8], board[zero + 12]]
      line = part if part.include? 0
      [upper_elem, lower_elem, line].flatten.compact
    end
end
