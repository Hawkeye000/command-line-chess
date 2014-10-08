require_relative '../lib/rook.rb'

describe Rook do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @rook = Rook.new("White", "A1")
    expect(@rook.icon).to eq("\u2656")
  end

  describe "valid moves" do
    before { @rook = Rook.new("white", "A5") }
    before { @board = Board.new }

    it "should be able to move vertically to any position" do
      expect(@rook.valid_move?("A3", @board)).to be_true
    end

    it "should be able to move horizontally to any position" do
      expect(@rook.valid_move?("H5", @board)).to be_true
    end

    it "should not be able to move diagonally" do
      expect(@rook.valid_move?("B3", @board)).to be_false
    end
  end

end