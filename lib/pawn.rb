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

  def valid_move?(new_loc, board)
    x, y = new_loc - @location

    y *= -1 if @color == "black"
    
    if x == 0 && y == 1
    elsif x == 0 && y == 2 && @moves == 0
    elsif y == 1 && x.abs == 1 && board[new_loc].opponent?(self)
    elsif en_passant?(new_loc, board)
    else
      return false
    end
    super

  end

  def en_passant?(new_loc, board)
    x, y = new_loc - @location
    passing_square = relative_square(@location, x, 0)

    passed_piece = board[passing_square]
    # conditions for en passant, must be opposing pawn that moved forward twice to 
    # the square it would have occupied if it was only moved one square
    if passed_piece.is_a?(Pawn) && self.opponent?(passed_piece) && passed_piece.moves == 1
      board.rv_piece(passing_square)
      return true
    else
      return false
    end
  end

end