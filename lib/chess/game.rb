require_relative "board.rb"
require_relative "player.rb"

class Game

  def initialize
    @board = Board.new
    @white_player = Player.new("white")
    @black_player = Player.new("black")
    @turn = @white_player
    @opponent = @black_player
    @movelist = []
  end

  def movelist
    @movelist
  end

  def save(file_name)
    File.open(file_name, 'wb+') do |file|
      Marshal.dump(self, file)
    end
  end

  def self.load(file_name)
    File.open(file_name) do |file|
      Marshal.load(file)
    end
  end

  def move(loc_1, loc_2)
    if @board[loc_1].color == @turn
      if @turn.move(loc_1, loc_2, @board)
        @turn, @opponent = @opponent, @turn
        @movelist << "#{@board[loc_2].icon} #{loc_1} #{loc_2}"
      end
    else
      nil
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

  def turn
    @turn
  end

  def opponent
    @opponent
  end

  def turn=(turn)
    @turn = turn
  end

  def opponent=(opponent)
    @opponent = opponent
  end
end
