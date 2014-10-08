require_relative 'move_helper.rb'

class Piece

  def initialize(color = "white", location = 'A1')
    @color = color
    @location = location.upcase
    @moves = 0
  end

  def color
    @color
  end

  def location
    @location
  end

  def icon
    @icon
  end

  def to_s
    @icon
  end

  def move(new_loc, board)
    if self.valid_move?(new_loc, board)
      @moves += 1
      return new_loc 
    else 
      return nil
    end
  end

  def valid_move?(new_loc, board)
    if board.piece_between?(@location, new_loc)
      return false unless self.is_a?(Knight)
    elsif board.board[new_loc].nil?
      return false
    else
      return true
    end
  end

end

