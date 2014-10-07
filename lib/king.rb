require_relative 'piece.rb'

WHITE_KING_ICON = "\u2654"
BLACK_KING_ICON = "\u265A"

class King < Piece

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_KING_ICON
    when "black"
      @icon = BLACK_KING_ICON
    end
    super
  end

end