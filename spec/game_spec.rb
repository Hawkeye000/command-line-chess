require_relative "../lib/chess/game.rb"

describe Game do

  it "should be able to save and load the game" do
    @game = Game.new
    @game.save("game.dat")
    @same_game = Game.load("game.dat")
    expect(@game.board.to_a).to eq(@same_game.board.to_a)
  end


end
