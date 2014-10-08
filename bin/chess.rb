require_relative '../lib/board.rb'

@board = Board.new

@w_player = Player.new("white")
@b_player = Player.new("black")

players = [@w_player, @b_player]

player = players[0]
opponent = players[1]

loop do 

  @board.display

  puts "#{player.color.capitalize} Player, enter your move:"
  locs = gets.chomp.split(" ")
  player.move(locs[0], locs[1], @board)

  player, opponent = opponent, player
  
end