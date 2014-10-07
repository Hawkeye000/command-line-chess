require_relative '../lib/pawn.rb'

describe Pawn do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @pawn = Pawn.new("White", "A1")
    expect(@pawn.icon).to eq("\u2659")
  end

end