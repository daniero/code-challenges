INPUT = 265149

# Yields all coordinates from in a straight line, starting at [`x`,`y`],
# moving `distance` cells in the given `direction`.
#
def path(x, y, direction, distance)
  make_path = ->(xs, ys) { [*xs].product([*ys]) }

  directions = [
    ->() { make_path[x.upto(x+distance), y] },   # 0 = right
    ->() { make_path[x, y.downto(y-distance)] }, # 1 = up
    ->() { make_path[x.downto(x-distance), y] },  # 2 = left
    ->() { make_path[x, y.upto(y+distance)] }   # 3 = down
  ]

  directions[direction%4][]
end

def each_twice
  1.step { |i| yield i; yield i; }
end

# Yields all coordinates in outwards moving spiral, excluding [0,0]
#
def spiral
  dir = 0
  x,y = 0,0

  each_twice do |n|
    path = path(x,y, dir, n)
      
    path.drop(1).each do |pos|
      yield pos
    end

    x,y = path.last
    dir+=1
  end
end


#
# Solution Part 1
#

(x, y), _ = to_enum(:spiral).with_index.find { |(_,_),i| i == INPUT - 2 }
puts (x.abs + y.abs)
