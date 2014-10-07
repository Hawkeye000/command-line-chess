require_relative '../lib/pawn.rb'

describe Pawn do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

end