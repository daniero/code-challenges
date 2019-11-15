require 'set'

def visited(directions)
  x, y = 0, 0
  visited = Set[[x, y]]

  directions.each do |go_x, go_y|
    x, y = x+go_x, y+go_y
    visited << [x, y]
  end

  visited
end

directions = File.open('../input/03.txt').each_char.map { |char|
  case char
  when '^' then [0, 1]
  when '>' then [1, 0]
  when 'v' then [0, -1]
  when '<' then [-1, 0]
  end
}

# Part 1
puts visited(directions).size

# Part 2
santa, robot = directions.each_slice(2).to_a.transpose
puts (visited(santa) + visited(robot)).size
