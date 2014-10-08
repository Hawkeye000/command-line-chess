require_relative '../lib/board.rb'

@board = Board.new

@board.display

@board.rv_piece("F1")
@board.rv_piece("G1")

@board.display

@board.move("E1", "G1")

@board.display

@board.move("D2", "D4")

@board.display

puts @board.piece_between?("E1", "G1")