require_relative 'piece.rb'

class Queen < Piece

  WHITE_QUEEN_ICON = "\u2655"
  BLACK_QUEEN_ICON = "\u265B"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_QUEEN_ICON
    when "black"
      @icon = BLACK_QUEEN_ICON
    end
    super
  end

  def valid_move?(new_loc, board)
    x, y = new_loc - @location
    if x.abs == y.abs
    elsif x == 0 && y.abs > 0
    elsif y == 0 && x.abs > 0
    else
      return false
    end
    super
  end

end