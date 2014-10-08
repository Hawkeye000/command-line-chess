require_relative '../lib/piece.rb'

describe Piece do 

  it { should respond_to :color }
  it { should respond_to :location }
  it { should respond_to :move }

  describe "validating moves" do

    # see specific piece specs

  end

end