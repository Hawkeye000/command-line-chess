require_relative '../lib/king.rb'

describe King do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @king = King.new("White", "A1")
    expect(@king.icon).to eq("\u2654")
  end

end