require_relative 'move_helper.rb'

class Piece

  def initialize(color = "white", location = 'A1')
    @color = color
    @location = location.upcase
    @moves = 0

    # for determining en passant
    @passable = false
    @passed = false
  end

  def passable?
    @passable
  end

  def passable=(o)
    @passable = o
  end

  def passed?
    @passed
  end

  def passed=(o)
    @passed = o
  end

  def moves
    @moves
  end

  def moves=(moves)
    @moves = moves
  end

  def color
    @color
  end

  def location
    @location
  end

  def file
    @location[0]
  end

  def rank
    @location[1]
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

  def can_promote?
    ((@color == "white" && self.rank == "8") || (@color == "black" && self.rank == "1")) && self.is_a?(Pawn)
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
    if board[new_loc].nil?
      board.move_status = "Position is off the board"
      return false
    elsif @location == new_loc
      board.move_status = "Piece must move"
      return false
    elsif board.piece_between?(@location, new_loc)
      board.move_status = "Piece in between move"
      return false
    elsif self.friend?(board[new_loc])
      board.move_status = "Can't take your own piece"
      return false
    else
      return true
    end
  end

  def ==(o)
    o.class == self.class && o.state == state
  end
  alias_method :eql?, :==

  protected

    def state
      [@color, @location, @moves]
    end

end
