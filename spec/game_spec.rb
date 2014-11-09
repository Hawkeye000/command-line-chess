require_relative "../lib/chess/game.rb"
require 'spec_helper'

describe Game do

  before { @game = Game.new }

  it "should be able to save and load the game" do
    @game.save("game.dat")
    @same_game = Game.load("game.dat")
    expect(@game.board.to_a).to eq(@same_game.board.to_a)
  end

  it "should keep a record of moves made" do
    @game.move("D2", "D4")
    expect(@game.movelist.first == "#{Pawn::WHITE_PAWN_ICON} D2 D4")
  end

  it "should swap the player and opponent" do
    @game.move("D2", "D4")
    expect(@game.turn == @game.black_player)
  end

end
