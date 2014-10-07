require_relative '../lib/knight.rb'

describe Knight do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @knight = Knight.new("White", "A1")
    expect(@knight.icon).to eq("\u2658")
  end

end