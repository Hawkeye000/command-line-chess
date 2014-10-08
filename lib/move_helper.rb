class String

  # "-" overloaded on string to assist in differencing algebraic notation strings
  def -(next_loc)
    if next_loc.length == 2 && self.length == 2
      x = self[0].ord - next_loc[0].ord
      y = self[1].ord - next_loc[1].ord
      return x, y
    end
  end

end