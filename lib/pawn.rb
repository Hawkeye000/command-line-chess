require_relative 'piece.rb'

class Pawn < Piece

  WHITE_PAWN_ICON = "\u2659"
  BLACK_PAWN_ICON = "\u265F"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_PAWN_ICON
    when "black"
      @icon = BLACK_PAWN_ICON
    end
    super
  end

  def valid_move?(new_loc)
    x, y = new_loc - @location

    y *= -1 if @color == "black"
    
    if x == 0 && y == 1
      return true
    elsif x == 0 && y == 2 && @moves == 0
      return true
    else
      super
    end

  end


end