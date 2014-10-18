Dir[File.dirname(__FILE__) + '/*'].each { |file| require file }
require 'colorize'

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
            " "
          end 
        @board[loc] = piece
      end
    end
  end

  def set_piece(piece)
    @board[piece.location] = piece
  end

  def rv_piece(location)
    @board[location] = " " unless @board[location].nil?
  end

  def board
    @board
  end

  def [](string)
    @board[string]
  end

  def each(&block)
    @board.each(&block)
  end

  def clear
    @board.each { |square, piece| @board[square] = " " }
  end

  def move(loc_1, loc_2)
    return nil if loc_1.nil? || loc_2.nil?
    piece = @board[loc_1]
    if piece.move(loc_2, self)
      @board[loc_1] = " "
      self.set_piece(piece)
      castle_complement(piece, self)
      return loc_2
    else 
      return nil
    end
  end

  def display
    puts "  " + ("A".."H").to_a.join(" ")
    ("1".."8").to_a.reverse.each do |row|
      print row + " "
      ("A".."H").each do |col|
        background =
          if (col.ord + row.to_i).even?
            :black
          else
            :red
          end
        print (@board["#{col}#{row}"].to_s + " ").colorize(:background => background)
        end
      print " #{row}\n"
    end
    puts "  " + ("A".."H").to_a.join(" ")
  end

  def on_board?(loc)
    !@board[loc].nil?
  end

  def piece_between?(loc_1, loc_2)
    return false if loc_1 == loc_2
    squares_between(loc_1, loc_2).any? { |square| @board[square] != " " }
  end

end