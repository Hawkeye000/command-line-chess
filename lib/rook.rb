require_relative 'piece.rb'

class Rook < Piece

  WHITE_ROOK_ICON = "\u2656"
  BLACK_ROOK_ICON = "\u265C"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_ROOK_ICON
    when "black"
      @icon = BLACK_ROOK_ICON
    end
    super
  end

  def valid_move?(new_loc, board)
    x, y = new_loc - @location

    if x == 0 && y.abs > 0
    elsif y == 0 && x.abs > 0
    else
      return false
    end
    super
  end

end