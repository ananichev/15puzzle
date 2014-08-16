class PuzzlePagesController < ApplicationController
  
  after_action :prepare_board, only: :index
	
  def index
  	session[:board] = nil
  end
  
  def play
  	@board = session[:board]
  end
  
  def move_elem
  	@elements = session[:board].flatten
    elem = params[:elem].to_i
  	zero = @elements.index(0)
  	moved = @elements.index(elem)
  	@elements[zero] = @elements[moved]
  	@elements[moved] = 0
  	@board = []
  	@elements.each_slice(4) { |e| @board << e }
  	session[:board] = @board
  	redirect_to play_path
  end
  
  private
  
	def prepare_board
	  @elem = (1..15).to_a.shuffle
  	  @board = []
  	  @elem.each_slice(4) { |e| @board << e }
  	  @board[3] << 0
  	  session[:board] = @board
	end
	
end
