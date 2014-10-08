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
    if board.board[loc_1].color == @color
      board.move(loc_1, loc_2)
    end
    
  end
end