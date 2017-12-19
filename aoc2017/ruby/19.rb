DIRECTIONS = [
  UP = [0,-1],
  LEFT = [-1,0],
  DOWN = [0,1],
  RIGHT = [1,0]
]

def move(from_x, from_y, direction)
  [from_x + direction[0], from_y + direction[1]]
end

def turn(x,y, dir, grid)
  curr = DIRECTIONS.index(dir)
  DIRECTIONS.values_at((curr+1)%4, (curr-1)%4).find { |i,j| grid[y+j][x+i] =~ /\S/ }
end

input = File.readlines('../input19.txt')

x = input.first.index(/\S/)
y = 0
dir = DOWN

letters = []

loop do
  x,y = move(x,y, dir)
  cell = input[y][x]

  case cell
  when '+'
    dir = turn(x,y, dir, input)
  when /[A-Z]/
    letters << cell
  when /\s/
    break
  end

end

puts letters.join
