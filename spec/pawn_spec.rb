require_relative '../lib/pawn.rb'
require 'stringio'

describe Pawn do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @pawn = Pawn.new("White", "A1")
    expect(@pawn.icon).to eq("\u2659")
  end

  it "white should print the white pawn character" do
    @pawn = Pawn.new("white")
    $stdout = StringIO.new
    print @pawn
    expect($stdout.string).to include("\u2659")
  end

  it "black should print the white pawn character" do
    @pawn = Pawn.new("black")
    $stdout = StringIO.new
    print @pawn
    expect($stdout.string).to include("\u265F")
  end

  describe "valid moves" do
    before { @white_pawn = Pawn.new("white", "D2") }

    it "should be able to move forward once ordinarility" do
      expect(@white_pawn.valid_move?("D3")).to be_true
    end

    it "should be able to move forward twice on the first move" do
      expect(@white_pawn.valid_move?("D4")).to be_true
    end

    it "should not be able to move forward three times" do
      expect(@white_pawn.valid_move?("D5")).to be_false
    end

  end

end