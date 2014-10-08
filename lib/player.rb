class Player

  def initialize(color = "white")
    @color = color
  end


  def color
    @color
  end

  def move(loc_1, loc_2, board)
    loc_1.upcase!
    loc_2.upcase!
    if board.board[loc_1].color == @color
      board.move(loc_1, loc_2)
    end
  end
end