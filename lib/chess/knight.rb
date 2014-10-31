require_relative 'piece.rb'

class Knight < Piece

  WHITE_KNIGHT_ICON = "\u2658"
  BLACK_KNIGHT_ICON = "\u265E"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_KNIGHT_ICON
    when "black"
      @icon = BLACK_KNIGHT_ICON
    end
    super
  end

  def valid_move?(new_loc, board)
    x, y = new_loc - @location
    if (x.abs == 2 && y.abs == 1) || (x.abs == 1 && y.abs == 2)
    else
      board.move_status = "Knights cannot make that move."
      return false
    end
    super
  end

end
