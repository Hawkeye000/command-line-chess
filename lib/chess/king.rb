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
    elsif check_castle(self, board, x) && !self.check?(board)
    else
      return false
    end
    super(new_loc, board)
  end

  def check?(board)
    board.each do |loc, piece|
      if piece.opponent?(self) && piece.valid_move?(@location, board)
        return true
      end
    end
    return false
  end

  def checkmate?(board)
    # the king must be in check to be in checkmate
    unless self.check?(board)
      return false
    end

    kings_men = []
    squares = []

    # check all possible moves and see if the king is still in check
    board.board.keys.each do |loc_1|
      board.board.keys.each do |loc_2|
        if board[loc_1].friend?(self)
          still_in_check = self.will_be_in_check?(loc_1, loc_2, board)
          if still_in_check.nil?
            next
          elsif !still_in_check
            return false
          end
        end
      end
    end

    return true
  end

  def stalemate?(board)
    # the king must be in check to be in checkmate
    if self.check?(board)
      return false
    end

    kings_men = []
    squares = []

    # check all possible moves and see if the king is put in check
    board.board.keys.each do |loc_1|
      board.board.keys.each do |loc_2|
        if board[loc_1].friend?(self)
          still_in_check = self.will_be_in_check?(loc_1, loc_2, board)
          if still_in_check.nil?
            next
          elsif still_in_check == false
            return false
          end
        end
      end
    end

    return true
  end

  def will_be_in_check?(loc_1, loc_2, board)
    test_board = Marshal.load(Marshal.dump(board))
    test_king = test_board[@location]
    if test_board.move(loc_1, loc_2)
      check = test_king.check?(test_board)
      return check
    else
      return nil
    end
  end

end
