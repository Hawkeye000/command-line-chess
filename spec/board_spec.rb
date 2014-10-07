require_relative '../lib/board.rb'

describe Board do 

  it { should respond_to :board }

  describe "algebraic notation" do

    before { @board = Board.new }

    it "should respond to algebraic notation" do
      @board.board["A1"] = "Hello"
      expect(@board.board["A1"]).to eq("Hello")
    end

    it "should return nil if the hash is out of bounds" do
      expect(@board.board["Z8"]).to be nil
    end

    it "should return empty if the hash is in bounds" do
      expect(@board.board["A1"]).to eq("empty")
    end
    
  end

end