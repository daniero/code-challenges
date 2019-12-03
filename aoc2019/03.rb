require 'set'

Direction2coord = {
  'R' => [1, 0],
  'D' => [0, 1],
  'L' => [-1, 0],
  'U' => [0, -1],
}

def go(directions)
  position = [0,0]
  visited = Set[]

  directions.each do |step|
    coord = Direction2coord[step]
    position = position.zip(coord).map { |e| e.inject :+ }
    visited << position
  end

  visited
end

def distance(coord)
  coord.sum(&:abs)
end

wires = File
  .readlines('input/input03.txt')
  .map { |line| line
                  .scan(/([RLUD])(\d+)/)
                  .flat_map { |d,n| [d] * n.to_i }
  }
  .map(&method(:go))

intersections = wires.inject(:&)

p intersections.map(&method(:distance)).min
