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

  def board
    @board
  end

  def display
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
      print "\n"
    end
    puts "  " + ("A".."H").to_a.join(" ")
  end

  def on_board?(loc)
    !@board[loc].nil?
  end

  def squares_between(loc_1, loc_2)
    x, y = loc_2 - loc_1
    if x != 0 && y == 0
      if x > 0 
        x_range = (loc_1[0]..loc_2[0]).to_a
      elsif x < 0
        x_range = (loc_2[0]..loc_1[0]).to_a.reverse
      end
      y_range = Array.new(x_range.length, loc_1[1])
    elsif x == 0 && y != 0
      if y > 0
        y_range = (loc_1[1]..loc_2[1]).to_a
      elsif y > 0
        y_range = (loc_2[1]..loc_1[1]).to_a.reverse
      end
      x_range = Array.new(y_range.length, loc_1[0])
    end

    # zip up the ranges to made a clean list of square between
    squares_between = []
    x_range.zip(y_range).each { |x| squares_between << x.join }
    # trim off the first and last squares
    squares_between.delete_at(0)
    squares_between.delete_at(-1)
    return squares_between
  end

  def piece_between?(loc_1, loc_2)

  end

end