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

  def move(new_loc, board)
    x, y = new_loc - @location
    @passable = true if y.abs == 2
    super
  end

  def valid_move?(new_loc, board)
    x, y = new_loc - @location

    y *= -1 if self.black?

    if x == 0 && y == 1 && board[new_loc] == " "
    elsif x == 0 && y == 2 && @moves == 0 && board[new_loc] == " "
    elsif y == 1 && x.abs == 1 && board.board[new_loc].opponent?(self)
    elsif en_passant?(new_loc, board)
    else
      board.move_status = "Pawns cannot make that move."
      return false
    end
    super

  end

  def en_passant?(new_loc, board)
    x, y = new_loc - @location
    return false unless x.abs == 1 && y.abs == 1
    passing_square = relative_square(@location, x, 0)
    passed_piece = board[passing_square]
    return false unless passed_piece.is_a?(Pawn)
    # conditions for en passant, must be opposing pawn that moved forward twice to
    # the square it would have occupied if it was only moved one square
    if self.opponent?(passed_piece) && passed_piece.passable?
      # board.rv_piece(passing_square)
      passed_piece.passed = true
      return passed_piece.location
    else
      return false
    end
  end

end
