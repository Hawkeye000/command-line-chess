class Player

  def initialize(color = "white")
    @color = color
  end


  def color
    @color
  end

  def move(loc_1, loc_2, board)

    return nil unless loc_1.is_a?(String) && loc_2.is_a?(String)

    loc_1.upcase!
    loc_2.upcase!

    return nil unless loc_1[0].file? && loc_2[0].file? && loc_1[1].rank? && loc_2[1].file?
    if board.board[loc_1].color == @color
      board.move(loc_1, loc_2) unless self.king(board).will_be_in_check?(loc_1, loc_2, board)
    end
    
  end

  def king(board)
    king = board.board.select do |square, piece|
      return piece if piece.color == self.color && piece.class == King
    end
  end
end