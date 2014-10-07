

class Board

  def initialize
    @board = Hash.new
    ("A".."H").each do |letter|
      ("1".."8").each do |number|
        @board["#{letter}#{number}"] = "empty"
      end
    end
  end

  def board
    @board
  end

end