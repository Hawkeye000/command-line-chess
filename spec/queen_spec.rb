require_relative '../lib/queen.rb'

describe Queen do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @queen = Queen.new("White", "A1")
    expect(@queen.icon).to eq("\u2655")
  end

end