class String

  # "-" overloaded on string to assist in differencing algebraic notation strings
  def -(next_loc)
    if next_loc.length == 2 && self.length == 2
      x = self[0].ord - next_loc[0].ord
      y = self[1].ord - next_loc[1].ord
      return x, y
    end
  end

  def color
    nil
  end

end

def squares_between(loc_1, loc_2)
  x, y = loc_2 - loc_1

  if x > 0 
    x_range = (loc_1[0]..loc_2[0]).to_a
  elsif x < 0
    x_range = (loc_2[0]..loc_1[0]).to_a.reverse
  end
  if y > 0
    y_range = (loc_1[1]..loc_2[1]).to_a
  elsif y < 0
    y_range = (loc_2[1]..loc_1[1]).to_a.reverse
  end

  if x != 0 && y == 0
    y_range = Array.new(x_range.length, loc_1[1]) 
  elsif x == 0 && y != 0
    x_range = Array.new(y_range.length, loc_1[0])  
  end

  # zip up the ranges to made a clean list of square between
  squares_between = []
  x_range.zip(y_range).each { |x| squares_between << x.join }

  # trim off the first and last squares
  squares_between.delete_at(0)
  squares_between.delete_at(-1)
  return squares_between
end

def check_castle(king, board, horiz_move)
  if king.moves > 0 || horiz_move.abs != 2
    return false
  end

  if king.black?
    return false unless king.location == "E8"
    queen_rook = board.board["A8"]
    king_rook = board.board["H8"]
  elsif king.white?
    return false unless king.location == "E1"
    queen_rook = board.board["A1"]
    king_rook = board.board["H1"]
  else 
    return nil
  end

  if horiz_move < 0
    queen_rook.is_a?(Rook) && queen_rook.moves == 0 ? true : false
  elsif horiz_move > 0
    king_rook.is_a?(Rook) && king_rook.moves == 0 ? true : false
  end
end

# check if a castling move was done by the king and move the complementary rook
def castle_complement(piece, board)
  if piece.moves == 1
    if piece.is_a?(King)
      # pick up the king so the rook can move
      board.rv_piece(piece.location)
      case piece.location
      when "C1"
        board.move("A1", "D1")
      when "G1"
        board.move("H1", "F1")
      when "C8"
        board.move("A8", "D8")
      when "G8"
        board.move("H8", "F8")
      end
      # replace the king after
      board.set_piece(piece)
    end
  end 
end

def relative_square(location, x, y)
  (location[0].ord + x).chr + (location[1].ord + y).chr
end