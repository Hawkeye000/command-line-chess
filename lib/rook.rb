require_relative 'piece.rb'

WHITE_ROOK_ICON = "\u2656"
BLACK_ROOK_ICON = "\u265C"

class Rook < Piece

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_ROOK_ICON
    when "black"
      @icon = BLACK_ROOK_ICON
    end
    super
  end

end