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
    before do 
      @board = Board.new
      @white_pawn = @board.board["D2"]
      @black_pawn = @board.board["D7"]
    end

    it "should be able to move forward once ordinarility" do
      expect(@white_pawn.valid_move?("D3", @board)).to be_true
    end

    it "should be able to move forward once ordinarility" do
      expect(@black_pawn.valid_move?("D6", @board)).to be_true
    end

    it "should be able to move forward twice on the first move" do
      expect(@white_pawn.valid_move?("D4", @board)).to be_true
    end

    it "should not be able to move forward three times" do
      expect(@white_pawn.valid_move?("D5", @board)).to be_false
    end

    it "should not be able to move left or right" do
      expect(@white_pawn.valid_move?("C2", @board)).to be_false
    end

    it "should not be able to move diagonally" do
      expect(@white_pawn.valid_move?("C3", @board)).to be_false
    end

    it "should not be able to move backwards" do
      expect(@white_pawn.valid_move?("D1", @board)).to be_false
    end

  end

  describe "taking other pieces" do

    it "should be able to move diagonally to take other pieces" do
      @board = Board.new
      @white_pawn = @board.board["D2"]
      @black_pawn = Pawn.new("black", "C3")
      @board.set_piece(@black_pawn)
      expect(@white_pawn.valid_move?("C3", @board)).to be_true
    end
   
    it "should be able to capture pieces en passant (in passing)" do
      @board = Board.new
      @white_pawn = @board.board["D2"]
      @black_pawn = @board.board["E7"]
      @board.move("D2", "D4")
      @board.move("D4", "D5")
      @board.move("E7", "E5")
      @board.move("D5", "E6")
      expect(@board.board["E5"]).to eq(" ")
    end
  end

end