require_relative 'piece.rb'

WHITE_PAWN_ICON = "\u2659"
BLACK_PAWN_ICON = "\u265F"

class Pawn < Piece

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_PAWN_ICON
    when "black"
      @icon = BLACK_PAWN_ICON
    end
    super
  end

end