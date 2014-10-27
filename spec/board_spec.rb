require_relative '../lib/chess/board.rb'

describe Board do

  before { @board = Board.new }

  it { should respond_to :board }
  it { should respond_to :piece_between? }

  describe "algebraic notation" do

    it "should respond to algebraic notation" do
      @board.board["A1"] = "Hello"
      expect(@board.board["A1"]).to eq("Hello")
    end

    it "should return nil if the hash is out of bounds" do
      expect(@board.board["Z8"]).to be nil
    end

    it "should not be nil if the hash is in bounds" do
      expect(@board.board["A1"]).to_not be nil
    end

  end

  describe "setting up the game" do

    it "should have a pawn on A2" do
      expect(@board.board["A2"]).to be_a(Pawn)
    end

    it "should have a queen on D8" do
      expect(@board.board["D8"]).to be_a(Queen)
    end

    it "should be empty on D4" do
      expect(@board.board["D4"]).to eq(" ")
    end

  end

  it "should be able to set pieces on the board" do
    @white_pawn = Pawn.new("white", "D4")
    @board.set_piece(@white_pawn)
    expect(@board.board["D4"]).to eq(@white_pawn)
  end

  it "should be able to remove pieces from the board" do
    @board.rv_piece("E5")
    expect(@board.board["E5"]).to eq(" ")
  end

  describe "making moves" do

    it "should know when a notation refers to a spot off the board" do
      expect(@board.on_board?("Z1")).to be_falsey
    end

    it "should know when a notation refers to a spot on the board" do
      expect(@board.on_board?("A1")).to be_truthy
    end

    describe "knowing which squares are between two locations" do

      it "should be able to see the squares between on a veritcal move" do
        expect(squares_between("A1", "A5")).to eq(["A2", "A3", "A4"])
      end

      it "should be able to see the squares between on a horizontal move" do
        expect(squares_between("H8", "C8")).to eq(["G8", "F8", "E8", "D8"])
      end

      it "should be albe to see the squares between on a diagonal move" do
        expect(squares_between("H8", "C3")).to eq(["G7", "F6", "E5", "D4"])
      end

    end

    describe "return value" do
      it "should return the square a piece moved to" do
        expect(@board.move("B8", "A6")).to eq("A6")
      end

      it "should not return the square if the move is bad" do
        expect(@board.move("B8", "B6")).to_not eq("B6")
      end
    end

    describe "piece between" do
      it "should know when pieces are in between two locations" do
        expect(@board.piece_between?("A1", "A3")).to be_truthy
      end

      it "should know when there are no pieces in between two locations" do
        expect(@board.piece_between?("A2", "A4")).to be_falsey
      end
    end

    describe "for white pawn" do

      before { @board.move("D2", "D4") }

      it "should be able to move a white pawn two spaces forward" do
        expect(@board.board["D4"]).to be_a(Pawn)
      end

      it "should not be able to move a white pawn two spaces on the next turn" do
        @board.move("D4", "D6")
        expect(@board.board["D6"]).to eq(" ")
      end

      it "should be able to move a white pawn one space on the next turn" do
        @board.move("D4", "D5")
        expect(@board.board["D5"]).to be_a(Pawn)
      end
    end

    describe "for a white knight" do

      it "should be able to jump the front row of pawns" do
        @board.move("B1", "A3")
        expect(@board.board["A3"]).to be_a(Knight)
      end

      it "should not be able to take its own color" do
        @board.move("B1", "D2")
        expect(@board.board["D2"]).to be_a(Pawn)
      end

      describe "taking an opposing color" do
        before do
          @board.move("B1", "A3")
          @board.move("A3", "B5")
          @board.move("B5", "C7")
          @knight = @board.board["C7"]
        end

        it "should have a white piece on the square" do
          expect(@knight.color).to eq("white")
        end

        it "should be be a knight" do
          expect(@knight).to be_a(Knight)
        end
      end
    end

    describe "undoing moves" do

      it "should be able to undo moves" do
        @board.move("D2", "D4")
        @board.undo_last_move
        expect(@board["D2"]).to be_a(Pawn)
        expect(@board["D2"].moves).to eq(0)
      end

    end
  end

  describe "pawn promotion" do

    before do
      @board = Board.new
      @promote = Pawn.new("white", "A8")
      @board.set_piece(@promote)
    end

    it "should be able to promote to a queen" do
      @board.promote("A8", Queen)
      expect(@board["A8"]).to be_a(Queen)
    end

    it "should be able to promote to a Knight" do
      @board.promote("A8", Knight)
      expect(@board["A8"]).to be_a(Knight)
    end

    it "should be able to promote to a Bishop" do
      @board.promote("A8", Bishop)
      expect(@board["A8"]).to be_a(Bishop)
    end

    it "should be able to promote to a Rook" do
      @board.promote("A8", Rook)
      expect(@board["A8"]).to be_a(Rook)
    end

    it "should not be able to promote to a King" do
      @board.promote("A8", King)
      expect(@board["A8"]).to_not be_a(King)
    end

    it "should know when a piece can be promoted" do
      expect(@board.piece_to_promote?).to eq(@promote)
    end

  end

  it "should be able to clear the board" do
    @board.clear
    pieces = @board.board.select{ |square, piece| piece.is_a?(Piece)}
    expect(pieces.empty?).to be_truthy
  end

end
