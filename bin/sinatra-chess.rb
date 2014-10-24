require_relative '../lib/board.rb'
require 'sinatra'

set :views, Proc.new { File.join(root, "../views") }
set :public, Proc.new { File.join(root, "../public") }

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  "Click <a href = '/new_game'>here</a> to start a new game"
end

get '/new_game' do
  @game = Game.new

  @board = @game.board

  players = [@game.white_player, @game.black_player]

  player = @game.turn
  opponent = @game.opponent
end

get '/game' do
  @game = Game.new
  @board = @game.board
  erb :game, locals: {list: @board}
end
