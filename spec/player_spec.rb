require_relative "../lib/player.rb"
require_relative "../lib/board.rb"

describe Player do 
  
  it { should respond_to :color }
  it { should respond_to :move }

  describe "making moves" do
    before do
      @board = Board.new
      @w_player = Player.new("white")
      @b_player = Player.new("black")
    end
    it "should be able to move its own color" do
      @w_player.move("D2", "D3", @board)
      expect(@board["D3"]).to be_a(Pawn)
    end
    it "should not be able to move the other player's pieces" do
      @w_player.move("D7", "D6", @board)
      expect(@board["D6"]).to eq(" ")
    end
  end


end