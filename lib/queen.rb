require_relative 'piece.rb'

class Queen < Piece

  WHITE_QUEEN_ICON = "\u2655"
  BLACK_QUEEN_ICON = "\u265E"

  def initialize(color = "white", location = "A1")
    case color.downcase
    when "white"
      @icon = WHITE_QUEEN_ICON
    when "black"
      @icon = BLACK_QUEEN_ICON
    end
    super
  end

end