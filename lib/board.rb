require 'matrix'

class Board

  def initialize
    @board = Matrix.build(8)
  end

  def board
    @board
  end

end