class PuzzlePagesController < ApplicationController
	
  def index
  	@new_game = true
  end
  
  def play
    prepare_board
  end
  
  private
  
	def prepare_board
	  @elem = (1..15).to_a.shuffle
  	  @board = []
  	  @elem.each_slice(4) { |e| @board << e }
  	  @board[3] << 0
	end

end
