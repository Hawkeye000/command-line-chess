class Player

  def initialize(color = "white")
    @color = color
  end


  def color
    @color
  end

  def move(loc_1, loc_2, board)
    if board.board[loc_1].color == @color
      board.move(loc_1, loc_2)
    end
  end
end