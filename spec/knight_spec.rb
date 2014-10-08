require_relative '../lib/knight.rb'

describe Knight do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @knight = Knight.new("White", "A1")
    expect(@knight.icon).to eq("\u2658")
  end

  describe "valid moves" do
    before { @knight = Knight.new("white", "D4") }

    it "should be able to move in an 'L'" do
      expect(@knight.valid_move?("F5")).to be_true
    end

    it "should not be able to move horizontally to any position" do
      expect(@knight.valid_move?("H4")).to be_false
    end

    it "should not be able to move diagonally" do
      expect(@knight.valid_move?("B2")).to be_false
    end
  end

end