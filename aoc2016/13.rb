require 'set'
require 'pqueue'

INPUT = 1350
TARGET = [31,39]

DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

def distance(x,y)
  i,j = TARGET
  Math.sqrt((x-i)**2 + (y-j)**2)
end

walls = Hash.new do |h, (x, y)|
  n = x*x + 3*x + 2*x*y + y + y*y + INPUT
  bits = (0...n.bit_length).map { |i| n[i] }
  h[[x,y]] = bits.count(1).odd?
end

start = [0, [1,1]] # moves, [x,y]
queue = PQueue.new([start]) { |a, b| distance(*a[1]) < distance(*b[1]) }

def search(target, walls, queue)
  visited = Set.new

  loop do
    moves, (x,y) = queue.pop
    return moves if [x,y] == target

    visited << [x,y]

    DIRECTIONS.each do |i, j|
      new_x, new_y = x + i, y + j
      next if visited.include?([new_x, new_y])
      next if walls[[new_x, new_y]]
      next if new_x < 0 && new_y < 0

      go = [moves + 1, [new_x, new_y]]
      queue.push(go)
    end

  end
end

puts search(TARGET, walls, queue)
