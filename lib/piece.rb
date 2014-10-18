require_relative 'move_helper.rb'

class Piece

  def initialize(color = "white", location = 'A1')
    @color = color
    @location = location.upcase
    @moves = 0
  end

  def moves
    @moves
  end

  def color
    @color
  end

  def location
    @location
  end

  def location=(location)
    @location = location
  end

  def icon
    @icon
  end

  def to_s
    @icon
  end

  def black?
    @color == "black"
  end

  def white?
    @color == "white"
  end

  def opponent?(piece)
    piece.color != @color
  end

  def friend?(piece)
    piece.color == @color
  end

  def move(new_loc, board)
    if self.valid_move?(new_loc, board)
      @moves += 1
      @location = new_loc
    else 
      return nil
    end
  end

  def my_king(board)
    # tells a player where his beloved monarch is
    board.board.each do |location, piece| 
      if piece.is_a?(King) && piece.color == self.color
        return piece
      end
    end
  end

  def valid_move?(new_loc, board)
    if board.piece_between?(@location, new_loc)
      return false unless self.is_a?(Knight)
    elsif self.my_king(board).will_be_in_check?(@location, new_loc, board)
    elsif board[new_loc].nil?
      return false
    else
      return true
    end
  end

end

