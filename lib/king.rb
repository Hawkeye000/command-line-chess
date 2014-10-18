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
    return false unless self.check?(board)
    kings_men = []
    squares = []

    # check all possible moves and see if the king is still in check
    board.each do |loc, piece| 
      kings_men << piece if piece.color == self.color
      squares << loc
    end

    kings_men.each do |piece|
      squares.each do |new_loc|
        unless self.will_be_in_check?(piece.location, new_loc, board)
          return false
        end
      end
    end

    return true
  end

  def will_be_in_check?(loc_1, loc_2, board)
    board.move(loc_1, loc_2)
    check = self.check?(board)
    board.undo_last_move
    return check
  end

end