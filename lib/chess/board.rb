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

  def piece_to_promote?
    @board.each_value do |piece|
      if piece.is_a?(Piece)
        if piece.can_promote?
          return piece
        end
      end
    end
    return nil
  end

  def promote(loc, new_piece)
    piece = board[loc]
    new_piece = Kernel.const_get(new_piece.capitalize)
    if piece.can_promote?
      if new_piece == Queen || new_piece == Rook \
          || new_piece == Bishop || new_piece == Knight
        promoted = new_piece.new(piece.color, loc)
        promoted.moves = piece.moves
        self.rv_piece(loc)
        self.set_piece(promoted)
      end
    else
      nil
    end
  end

  def save_board
    @saved_board = Marshal.load(Marshal.dump(@board))
  end

  def move(loc_1, loc_2)
    return nil if loc_1.nil? || loc_2.nil?
    piece = @board[loc_1]
    self.save_board

    if piece.move(loc_2, self)
      @board[loc_1] = " "
      old_piece = @board[loc_2]
      self.set_piece(piece)
      rv_piece(self.passed_piece)
      castle_complement(piece, self)
      self.clear_passable
      return loc_2
    else
      return nil
    end

  end

  def clear_passable
    @board.each { |piece| piece.passable = false if piece.is_a?(Piece) }
  end

  def passed_piece
    @board.each_value { |piece| return piece.location if piece.passed? && piece.is_a?(Pawn) }
  end

  def restore_saved_board
    self.clear
    @board = Marshal.load(Marshal.dump(@saved_board))
  end

  def undo_last_move
    self.restore_saved_board
  end

  def to_a
    @board.to_a
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
    return false if self[loc_1].is_a?(Knight)
    squares_between(loc_1, loc_2).any? { |square| @board[square] != " " }
  end

end
