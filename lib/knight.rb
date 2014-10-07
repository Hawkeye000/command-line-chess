require_relative 'piece.rb'

WHITE_KNIGHT_ICON = "\u2658"
BLACK_KNIGHT_ICON = "\u265E"

class Knight < Piece

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_KNIGHT_ICON
    when "black"
      @icon = BLACK_KNIGHT_ICON
    end
    super
  end

end