require 'set'
require 'pqueue'

INPUT = 1350
TARGET = [31,39]

DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]

def distance(x,y)
  i,j = TARGET
  Math.sqrt((x-i)**2 + (y-j)**2)
end

def search(walls, queue, visited={})
  loop do
    state = queue.pop
    return nil unless state
    return state if yield state

    moves, (x, y) = state
    visited[[x,y]] = moves

    DIRECTIONS.each do |i, j|
      new_x, new_y = x + i, y + j
      next if visited.include?([new_x, new_y])
      next if walls[[new_x, new_y]]
      next if new_x < 0 || new_y < 0

      go = [moves + 1, [new_x, new_y]]
      queue.push(go)
    end

  end
end

walls = Hash.new do |h, (x, y)|
  n = x*x + 3*x + 2*x*y + y + y*y + INPUT
  bits = (0...n.bit_length).map { |i| n[i] }
  h[[x,y]] = bits.count(1).odd?
end

start = [0, [1,1]] # moves, [x,y]

# Part 1:
queue = PQueue.new([start]) { |a, b| distance(*a[1]) < distance(*b[1]) }
part1,_ = search(walls, queue) { |_, room| room == TARGET }
puts part1

# Part 2
visited_rooms = {}
queue = PQueue.new([start]) { |a, b| a[0] < b[0] }
search(walls, queue, visited_rooms) { |moves, _| moves > 50 }
puts visited_rooms.size


50.times do |y|
  204.times { |x| print visited_rooms[[x,y]] ? "·" : walls[[x,y]] ? "0" : " " }
  puts
end

