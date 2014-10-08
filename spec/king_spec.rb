require_relative '../lib/king.rb'

describe King do 

  it { should be_a_kind_of(Piece) }
  it { should respond_to :color }
  it { should respond_to :location }

  it "should know what its character is" do 
    @king = King.new("White", "A1")
    expect(@king.icon).to eq("\u2654")
  end

  describe "valid moves" do
    before { @king = King.new("white", "D4") }
    before { @board = Board.new }

    it "should be able to move vertically one position" do
      expect(@king.valid_move?("D3", @board)).to be_true
    end

    it "should be able to move horizontally one position" do
      expect(@king.valid_move?("C4", @board)).to be_true
    end

    it "should be able to move diagonally one position" do
      expect(@king.valid_move?("C3", @board)).to be_true
    end

    it "should not be able to move more than one position" do
      expect(@king.valid_move?("B2", @board)).to be_false
    end

    describe "castling" do

      before do 
        @board = Board.new
        @king = @board.board["E1"]
        @board.rv_piece("F1")
        @board.rv_piece("G1")
      end

      it "should be valid to move twice horizontally on the first move\ 
          when there is a rook on that side and no other pieces between" do
        expect(@king.valid_move?("G1", @board))
      end

      it "should move the king to the correct location" do
        @board.move("E1", "G1")
        expect(@board.board["G1"]).to be_a(King)
        expect(@king.location).to eq("G1")
      end

      it "should move the rook to the correct location" do
        @board.move("E1", "G1")
        expect(@board.board["F1"]).to be_a(Rook)
      end

    end
  end

end