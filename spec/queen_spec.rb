require_relative '../lib/queen.rb'

describe Queen do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @queen = Queen.new("White", "A1")
    expect(@queen.icon).to eq("\u2655")
  end

  describe "valid moves" do
    before { @queen = Queen.new("white", "D4") }

    it "should be able to move vertically to any position" do
      expect(@queen.valid_move?("D3")).to be_true
    end

    it "should be able to move horizontally to any position" do
      expect(@queen.valid_move?("H4")).to be_true
    end

    it "should be able to move diagonally" do
      expect(@queen.valid_move?("B2")).to be_true
    end
  end

end