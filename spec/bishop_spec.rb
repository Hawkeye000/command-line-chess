require_relative '../lib/bishop.rb'

describe Bishop do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @bishop = Bishop.new("White", "A1")
    expect(@bishop.icon).to eq("\u2657")
  end

end