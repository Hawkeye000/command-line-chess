require_relative '../lib/chess/knight.rb'
require_relative '../lib/chess/board.rb'

describe Knight do

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do
    @knight = Knight.new("White", "A1")
    expect(@knight.icon).to eq("\u2658")
  end

  describe "valid moves" do
    before { @knight = Knight.new("white", "D5") }
    before { @board = Board.new }

    it "should be able to move in an 'L'" do
      expect(@knight.valid_move?("F6", @board)).to be_truthy
      expect(@knight.valid_move?("F4", @board)).to be_truthy
      expect(@knight.valid_move?("E3", @board)).to be_truthy
      expect(@knight.valid_move?("E7", @board)).to be_truthy
      expect(@knight.valid_move?("C7", @board)).to be_truthy
      expect(@knight.valid_move?("B6", @board)).to be_truthy
      expect(@knight.valid_move?("B4", @board)).to be_truthy
      expect(@knight.valid_move?("C3", @board)).to be_truthy
    end

    it "should not be able to move horizontally to any position" do
      expect(@knight.valid_move?("H4", @board)).to be_falsey
    end

    it "should not be able to move diagonally" do
      expect(@knight.valid_move?("B2", @board)).to be_falsey
    end

    it "should be able to jump pieces" do
      expect(@board.board["B1"].valid_move?("C3", @board)).to be_truthy
    end

    it "should be able to block a checkmate" do
      @board.clear
      @board.set_piece(King.new("white", "E1"))
      @board.set_piece(King.new("black", "E8"))
      @board.set_piece(Queen.new("black", "E7"))
      @board.set_piece(Knight.new("white", "G1"))
      @board.set_piece(Pawn.new("white", "D1"))
      @board.set_piece(Pawn.new("white", "F2"))
      @board.set_piece(Pawn.new("white", "D2"))
      @board.set_piece(Rook.new("white", "F1"))
      @white_king = @board["E1"]
      expect(@white_king.checkmate?(@board)).to be_falsey
    end
  end

end
