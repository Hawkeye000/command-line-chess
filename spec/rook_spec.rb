require_relative '../lib/rook.rb'

describe Rook do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @rook = Rook.new("White", "A1")
    expect(@rook.icon).to eq("\u2656")
  end

end