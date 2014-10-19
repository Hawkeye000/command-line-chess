require_relative "board.rb"
require_relative "player.rb"

class Game

  def initialize
    @board = Board.new
    @white_player = Player.new("white")
    @black_player = Player.new("black")
  end

  def save(file_name)
    File.open(file_name, 'wb+') do |file|
      Marshal.dump(self, file)
    end
  end

  def load(file_name)
    File.open(file_name) do |file|
      Marshal.load(file)
    end
  end

  def board
    @board.board
  end

  def white_player
    @white_player
  end

  def black_player
    @black_player
  end

  def board
    @board
  end

end