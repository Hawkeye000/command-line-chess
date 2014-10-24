require_relative '../lib/board.rb'
require 'sinatra'

set :views, Proc.new { File.join(root, "../views") }
set :public, Proc.new { File.join(root, "../public") }

enable :sessions

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  "Click <a href = '/new_game'>here</a> to start a new game"
end

get '/new_game' do
  @game = Game.new

  session[:game] = @game
  redirect to('/game')

end

get '/game' do
  @game = session[:game]
  @board = @game.board
  erb :game, locals: {list: @board}
end

post '/game' do
  loc1 = params[:initial_position]
  loc2 = params[:new_position]
  @game = session[:game]
  @board = @game.board
  @board.move(loc1, loc2)
  session[:game] = @game
  erb :game, locals: {list: @board}
end
