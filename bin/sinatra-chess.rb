require_relative '../lib/board.rb'
require 'sinatra'

get '/' do

  @game = Game.new

  @board = @game.board

  players = [@game.white_player, @game.black_player]

  player = @game.turn
  opponent = @game.opponent

  loop do

    @board.display

    # look for pieces that need promotion
    promote = @board.piece_to_promote?
    if promote
      puts "Promote your piece, enter 'Queen', 'Knight', 'Bishop', or 'Rook'"
      new_piece = Kernel.const_get(gets.chomp.to_sym)
      @board.promote(promote.location, new_piece)
    end

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

    # handle special cases, otherwise run the move
    case locs[0]
    when "exit", "quit"
      puts "Are you sure? (y/n)"
      y_or_n = gets.chomp
      break if y_or_n[0].upcase == "Y"
    when "save"
      puts "enter a name to save the game as:"
      file_name = gets.chomp
      @game.save("save/#{file_name}")
      break
    when "load"
      puts "enter the name of the game you want to load:"
      file_name = gets.chomp
      @game = Game.load("save/#{file_name}")
      @board = @game.board
      players = [@game.white_player, @game.black_player]
      player, opponent = @game.turn, @game.opponent
    else
      unless player.move(locs[0], locs[1], @board).nil?
      player, opponent = opponent, player
      @game.turn = player
      @game.opponent = opponent
      else
        puts "Invalid move, try again".colorize(:red)
      end
    end
    
  end
end
