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

def squares_between(loc_1, loc_2)
  x, y = loc_2 - loc_1

  if x > 0 
    x_range = (loc_1[0]..loc_2[0]).to_a
  elsif x < 0
    x_range = (loc_2[0]..loc_1[0]).to_a.reverse
  end
  if y > 0
    y_range = (loc_1[1]..loc_2[1]).to_a
  elsif y < 0
    y_range = (loc_2[1]..loc_1[1]).to_a.reverse
  end

  if x != 0 && y == 0
    y_range = Array.new(x_range.length, loc_1[1]) 
  elsif x == 0 && y != 0
    x_range = Array.new(y_range.length, loc_1[0])  
  end

  # zip up the ranges to made a clean list of square between
  squares_between = []
  x_range.zip(y_range).each { |x| squares_between << x.join }

  # trim off the first and last squares
  squares_between.delete_at(0)
  squares_between.delete_at(-1)
  return squares_between
end