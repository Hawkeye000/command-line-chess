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

  def valid_move?(new_loc, board)
    x, y = new_loc - @location
    if x.abs <= 1 && y.abs <= 1
    elsif check_castle(self, board, x)
    else
      return false
    end
    super(new_loc, board)
  end

  def check?(board)
    board.each do |square, piece|
      if piece.opponent?(self) && piece.valid_move?(@location, board)
        return true
      end
    end
    return false
  end

  def will_be_in_check?(loc_1, loc_2, board)
    ghost_board = board.clone
    piece = board[loc_1]
    ghost_board.rv_piece(loc_1)
    piece.location = loc_2
    ghost_board.set_piece(piece)
    self.check?(ghost_board)
  end

end