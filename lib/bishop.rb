require_relative 'piece.rb'

class Bishop < Piece

  WHITE_BISHOP_ICON = "\u2657"
  BLACK_BISHOP_ICON = "\u265D"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_BISHOP_ICON
    when "black"
      @icon = BLACK_BISHOP_ICON
    end
    super
  end

  def valid_move?(new_loc)
    x, y = new_loc - @location
    if x == y
      return true
    else
      super
    end
  end

end