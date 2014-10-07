Dir[File.dirname(__FILE__) + '/*'].each { |file| require file }

class Board

  def initialize
    @board = Hash.new
    ("A".."H").each do |letter|
      ("1".."8").each do |number|
        loc = "#{letter}#{number}"
        piece =  
          if number == "7"
            Pawn.new("black", loc)
          elsif loc == "A8" || loc == "H8"
            Rook.new("black", loc)
          elsif loc == "B8" || loc == "G8"
            Knight.new("black", loc)
          elsif loc == "C8" || loc == "F8"
            Bishop.new("black", loc)
          elsif loc == "D8" 
            Queen.new("black", loc)
          elsif loc == "E8"
            King.new("black", loc)
          elsif number == "2"
            Pawn.new("white", loc)
          elsif loc == "A1" || loc == "H1"
            Rook.new("white", loc)
          elsif loc == "B1" || loc == "G1"
            Knight.new("white", loc)
          elsif loc == "C1" || loc == "F1"
            Bishop.new("white", loc)
          elsif loc == "D1" 
            Queen.new("white", loc)
          elsif loc == "E1"
            King.new("white", loc)
          else
            "empty"
          end 
        @board[loc] = piece
      end
    end
  end

  def board
    @board
  end

end