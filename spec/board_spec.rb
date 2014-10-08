require_relative '../lib/board.rb'

describe Board do 

  before { @board = Board.new }

  it { should respond_to :board }

  describe "algebraic notation" do

    it "should respond to algebraic notation" do
      @board.board["A1"] = "Hello"
      expect(@board.board["A1"]).to eq("Hello")
    end

    it "should return nil if the hash is out of bounds" do
      expect(@board.board["Z8"]).to be nil
    end

    it "should not be nil if the hash is in bounds" do
      expect(@board.board["A1"]).to_not be nil
    end
    
  end

  describe "setting up the game" do
  
    it "should have a pawn on A2" do
      expect(@board.board["A2"]).to be_a(Pawn)
    end

    it "should have a queen on D8" do
      expect(@board.board["D8"]).to be_a(Queen)
    end

    it "should be empty on D4" do
      expect(@board.board["D4"]).to eq(" ")
    end

  end

end