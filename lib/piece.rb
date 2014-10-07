class Piece

  def initialize(color = "white", location = 'A1')
    @color = color
    @location = location.upcase
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

end

