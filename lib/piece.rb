require_relative 'move_helper.rb'

class Piece

  def initialize(color = "white", location = 'A1')
    @color = color
    @location = location.upcase
    @moves = 0
  end

  def color
    @color
  end

  def location
    @location
  end

  def icon
    @icon
  end

  def to_s
    @icon
  end

  def move(new_loc)
    @moves += 1
    return new_loc if self.valid_move?
  end

  def valid_move?(new_loc)
    return false
  end

end

