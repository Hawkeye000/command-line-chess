require_relative 'piece.rb'

class King < Piece

  WHITE_KING_ICON = "\u2654"
  BLACK_KING_ICON = "\u265A"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_KING_ICON
    when "black"
      @icon = BLACK_KING_ICON
    end
    super
  end

  def valid_move?(new_loc)
    x, y = new_loc - @location
    if x.abs == y.abs && y.abs == 1
      return true
    elsif y == 0 && x.abs == 1
      return true
    elsif x == 0 && y.abs == 1
      return true
    else
      super
    end
  end

end