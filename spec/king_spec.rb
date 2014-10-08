require_relative '../lib/king.rb'

describe King do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @king = King.new("White", "A1")
    expect(@king.icon).to eq("\u2654")
  end

  describe "valid moves" do
    before { @king = King.new("white", "D4") }

    it "should be able to move vertically one position" do
      expect(@king.valid_move?("D3")).to be_true
    end

    it "should be able to move horizontally one position" do
      expect(@king.valid_move?("C4")).to be_true
    end

    it "should be able to move diagonally one position" do
      expect(@king.valid_move?("C3")).to be_true
    end

    it "should not be able to move more than one position" do
      expect(@king.valid_move?("B2")).to be_false
    end
  end

end