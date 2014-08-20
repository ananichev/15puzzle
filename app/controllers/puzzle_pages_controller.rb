class PuzzlePagesController < ApplicationController
  
  after_action :prepare_board, only: :index
	
  def index
    session[:board] = nil
  end
  
  def play
    if params[:win]
      @board = []
      ((1..14).to_a << 0 << 15).each_slice(4) { |e| @board << e }
      session[:board] = @board
    else
      @board = session[:board]
    end
    congratulations(@board)
  end
  
  def move_elem
    @elements = session[:board].flatten
    elem = params[:elem].to_i
    zero = @elements.index(0)
    moved = @elements.index(elem)
    l = [2, 3]
    r = [-2, -3]
    u = [-12, -8, 8, 12]
    if l.include?(zero - moved)
      @elements.insert(moved, 0).delete_at(zero + 1)
    elsif r.include?(zero - moved)
      @elements.insert(moved + 1, 0).delete_at(zero)
    elsif u.include?(zero - moved)
      @elements = vertical(session[:board], elem)
    else
      @elements[zero], @elements[moved] = @elements[moved], 0
    end
    @board = []
    @elements.each_slice(4) { |e| @board << e }
    session[:board] = @board
    respond_to do |format|
      format.html { redirect_to play_path }
      format.js
    end
  end

  private
  
    def prepare_board
      @elem = (1..15).to_a.shuffle
      @board = []
      @elem.each_slice(4) { |e| @board << e }
      @board[3] << 0
      session[:board] = @board
    end
	
    def congratulations(array)
      if array.flatten == (1..15).to_a << 0
        flash[:notice] = "Congratulations! You win"	
      end
    end

  def vertical(board, elem)
    @last = true  if board.flatten.index(0) < board.flatten.index(elem)

    unless @last
      board.each do |part|
        if part.include? elem
          @index = part.index(elem)
          if board.index(part) == 3
            @last = true
            break
          end
          part[@index] = 0
        elsif @index
          if part.include? 0
            part[@index] = elem
            break
          else
            part[@index], elem = elem,  part[@index]
          end
        end
      end
    else
      board.reverse!
      board.each do |part|
        if part.include? elem
          @index = part.index(elem)
          part[@index] = 0
        elsif @index
          if part.include? 0
            part[@index] = elem
            break
          else
            part[@index], elem = elem,  part[@index]
          end
        end
      end
      board.reverse!
    end
    board.flatten!
  end

end

