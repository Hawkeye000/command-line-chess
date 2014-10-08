require_relative '../lib/piece.rb'

describe Piece do 

  it { should respond_to :color }
  it { should respond_to :location }
  it { should respond_to :move }

  describe "validating moves" do

    it "should be invalid if the piece is not specific" do
      @piece = Piece.new
      expect(@piece.valid_move?('A1')).to be_false
    end

  end

end