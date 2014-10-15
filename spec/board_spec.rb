require_relative '../lib/board.rb'

describe Board do 

  before { @board = Board.new }

  it { should respond_to :board }
  it { should respond_to :piece_between? }

  describe "algebraic notation" do

    it "should respond to algebraic notation" do
      expect(@board["A1"]).to be_a(Rook)
    end

    it "should return nil if the hash is out of bounds" do
      expect(@board["Z8"]).to be nil
    end

    it "should not be nil if the hash is in bounds" do
      expect(@board["A1"]).to_not be nil
    end
    
  end

  describe "setting up the game" do
  
    it "should have a pawn on A2" do
      expect(@board["A2"]).to be_a(Pawn)
    end

    it "should have a queen on D8" do
      expect(@board["D8"]).to be_a(Queen)
    end

    it "should be empty on D4" do
      expect(@board["D4"]).to eq(" ")
    end

  end

  it "should be able to set pieces on the board" do
    @white_pawn = Pawn.new("white", "D4")
    @board.set_piece(@white_pawn)
    expect(@board["D4"]).to eq(@white_pawn)
  end

  it "should be able to remove pieces from the board" do
    @board.rv_piece("E5")
    expect(@board["E5"]).to eq(" ")
  end

  describe "making moves" do

    it "should know when a notation refers to a spot off the board" do
      expect(@board.on_board?("Z1")).to be_false
    end

    it "should know when a notation refers to a spot on the board" do
      expect(@board.on_board?("A1")).to be_true
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

    it "should know when pieces are in between two locations" do
      expect(@board.piece_between?("A1", "A3")).to be_true
    end

    it "should know when there are no pieces in between two locations" do
      expect(@board.piece_between?("A2", "A4")).to be_false
    end

    describe "for white pawn" do

      before { @board.move("D2", "D4") }

      it "should be able to move a white pawn two spaces forward" do
        expect(@board["D4"]).to be_a(Pawn)
      end

      it "should not be able to move a white pawn two spaces on the next turn" do
        @board.move("D4", "D6")
        expect(@board["D6"]).to eq(" ")
      end

      it "should be able to move a white pawn one space on the next turn" do
        @board.move("D4", "D5")
        expect(@board["D5"]).to be_a(Pawn)
      end
    end

    describe "for a white knight" do

      it "should be able to jump the front row of pawns" do
        @board.move("B1", "A3")
        expect(@board["A3"]).to be_a(Knight)
      end

      it "should not be able to take its own color" do
        @board.move("B1", "D2")
        expect(@board["D2"]).to be_a(Pawn)
      end

      describe "taking an opposing color" do
        before do 
          @board.move("B1", "A3")
          @board.move("A3", "B5")
          @board.move("B5", "C7")
          @knight = @board["C7"]
        end

        it "should have a white piece on the square" do 
          expect(@knight.color).to eq("white")
        end
        
        it "shoulbe be a knight" do
          expect(@knight).to be_a(Knight)
        end
      end
    end
  end

end