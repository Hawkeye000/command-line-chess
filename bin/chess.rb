require_relative '../lib/board.rb'

@game = Game.new

@board = @game.board

players = [@game.white_player, @game.black_player]

player = players[0]
opponent = players[1]

loop do 

  @board.display

  # look for check and checkmate conditions
  if player.king(@board).checkmate?(@board)
    puts "#{player.color.capitalize} Player, you are in " + "CHECKMATE".colorize(:red)
    puts "#{opponent.color.capitalize} Player " + "WINS".colorize(:green)
    break
  elsif player.king(@board).stalemate?(@board)
    puts "#{player.color.capitalize} Player, you are in " + "STALEMATE".colorize(:yellow)
    puts "DRAW"
    break
  elsif player.king(@board).check?(@board)
    puts "#{player.color.capitalize} Player, you are in " + "CHECK".colorize(:yellow)
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
  else
    puts "Invalid move, try again".colorize(:red) 
  end
  
end