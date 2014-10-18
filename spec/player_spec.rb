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
      expect(@board.board["D3"]).to be_a(Pawn)
    end
    it "should not be able to move the other player's pieces" do
      @w_player.move("D7", "D6", @board)
      expect(@board.board["D6"]).to eq(" ")
    end
  end

  it "should know which piece is their king" do
    @board = Board.new
    @w_player = Player.new("white")
    @b_player = Player.new("black")
    @w_king = @w_player.king(@board)
    @b_king = @b_player.king(@board)
    expect(@w_king).to be_a(King)
    expect(@b_king).to be_a(King)
    expect(@w_king.location).to eq("E1")
    expect(@b_king.location).to eq("E8")
  end


end