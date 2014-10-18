require_relative '../lib/board.rb'

@board = Board.new

@w_player = Player.new("white")
@b_player = Player.new("black")

players = [@w_player, @b_player]

player = players[0]
opponent = players[1]

loop do 

  @board.display

  # look for check and checkmate conditions
  if player.king(@board).checkmate?(@board)
    puts "#{player.color.capitalize} Player, you are in CHECKMATE"
    puts "#{opponent.color.capitalize} Player WINS"
    # break
  elsif player.king(@board).check?(@board)
    puts "#{player.color.capitalize} Player, you are in CHECK"
  end

  puts "#{player.color.capitalize} Player, enter your move:"
  locs = gets.chomp.split(" ")

  # handle special cases
  case locs[0]
  when "exit", "quit"
    break
  end

  unless player.move(locs[0], locs[1], @board).nil?
    player, opponent = opponent, player
  end
  
end