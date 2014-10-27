require_relative '../lib/chess/king.rb'

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
      expect(@king.valid_move?("D3", @board)).to be_truthy
    end

    it "should be able to move horizontally one position" do
      expect(@king.valid_move?("C4", @board)).to be_truthy
    end

    it "should be able to move diagonally one position" do
      expect(@king.valid_move?("C3", @board)).to be_truthy
    end

    it "should not be able to move more than one position" do
      expect(@king.valid_move?("B2", @board)).to be_falsey
    end

    describe "castling" do

      before do
        @board = Board.new
        @king = @board["E1"]
        @board.rv_piece("F1")
        @board.rv_piece("G1")
      end

      it "should be valid to move twice horizontally on the first move\
          when there is a rook on that side and no other pieces between" do
        expect(@king.valid_move?("G1", @board))
      end

      it "should move the king to the correct location" do
        @board.move("E1", "G1")
        expect(@board["G1"]).to be_a(King)
        expect(@king.location).to eq("G1")
      end

      it "should move the rook to the correct location" do
        @board.move("E1", "G1")
        expect(@board["F1"]).to be_a(Rook)
      end

      it "should not be able to castle if it is in check" do
        @board.move("E7", "E6")
        @board.move("D2", "D3")
        @board.move("F8", "B4")
        # king is now in check
        expect(@king.valid_move?("G1", @board)).to be_falsey
      end

      it "should not be able to castle into check" do
        @board.move("E7", "E6")
        @board.move("D8", "G5")
        @board.move("G5", "G2")
        expect(@king.valid_move?("G1", @board)).to be_falsey
      end

      it "should not be able to pass through a square being attacked" do
        @board.move("E7", "E6")
        @board.move("D8", "F6")
        @board.move("F2", "F3")
        @board.move("F6", "F3")
        expect(@king.check?(@board)).to be_falsey
        expect(@king.valid_move?("G1", @board)).to be_falsey
      end

    end
  end

  describe "in_check?" do

    before do
      @board = Board.new
      @black_king = @board["E8"]
      @white_king = @board["E1"]
    end

    it "should know when it is in check" do
      @board.move("C2", "C3")
      @board.move("D7", "D6")
      @board.move("D1", "A4")
      expect(@black_king.check?(@board)).to be_truthy
    end

    it "should know when it is not in check" do
      expect(@black_king.check?(@board)).to be_falsey
    end

    it "should know when it will be in check" do
      @board.move("E2", "E3")
      @board.move("F1", "B5")
      expect(@black_king.will_be_in_check?("D7", "D6", @board)).to be_truthy
    end

    it "should not be in checkmate if the king is not in check" do
      expect(@white_king.checkmate?(@board)).to be_falsey
    end

    it "should know when a check is a checkmate" do
      @board.move("F2", "F3")
      @board.move("E7", "E5")
      @board.move("G2", "G4")
      @board.move("D8", "H4")
      expect(@white_king.checkmate?(@board)).to be_truthy
    end

    it "should know when a check is not a checkmate" do
      @board.move("F2", "F3")
      @board.move("E7", "E5")
      @board.move("G1", "H3")
      @board.move("D8", "H4")
      expect(@white_king.checkmate?(@board)).to be_falsey
    end

    it "should know when a game is a stalemate" do
      @board.clear
      @white_king.location = "H1"
      @white_pawn = Pawn.new("white", "H2")
      @black_pawn = Pawn.new("black", "H3")
      @black_rook = Rook.new("black", "G4")
      @board.set_piece(@black_king)
      @board.set_piece(@white_king)
      @board.set_piece(@black_rook)
      @board.set_piece(@white_pawn)
      @board.set_piece(@black_pawn)
      expect(@white_king.checkmate?(@board)).to be_falsey
      expect(@white_king.stalemate?(@board)).to be_truthy
    end


  end

end
