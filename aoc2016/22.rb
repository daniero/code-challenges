Node = Struct.new(:size, :used, :avail)

input = File.open('input/22.txt').each_line.drop(1)

nodes = input.reduce({}) { |hash, line|
  line =~ /x(\d+)-y(\d+).*?(\d+)T.*?(\d+)T.*?(\d+)T/
  _, x, y, size, used, avail = [*$~].map(&:to_i)
  hash.merge({ [x,y] => Node.new(size, used, avail) })
}

# Part 1

p nodes.values
  .repeated_permutation(2)
  .select { |a, b| a.used != 0 }
  .select { |a,b| a != b }
  .count { |a, b| a.used <= b.avail }

# Part 2

WIDTH = nodes.keys.max_by { |x,_| x }.first + 1
HEIGHT = nodes.keys.max_by { |_,y| y }.last + 1
TARGET = [0, 0]

def distance(a, b)
  x,y = a
  i,j = b
  Math.sqrt((x-i)**2 + (y-j)**2)
end

State = Struct.new(:moves, :source, :empty, :prev) do
  def move(to)
    new_empty = to
    new_source = (to == source ? empty : source)
    State.new(moves + 1, new_source, new_empty)
  end

  def from(other)
    State.new(moves, source, empty, other)
  end

  def >(other)
    this = [distance(empty, source), distance(source, TARGET)]
    that = [distance(other.empty, other.source), distance(other.source, TARGET)]

    (this <=> that) == -1
  end

  def hash
    source.hash ^ empty.hash
  end

  def eql? other
    source.eql?(other.source) && empty.eql?(other.empty)
  end
end

require "set"
require "pqueue"

def search(start, possible_moves)
  queue = PQueue.new([start]) { |a,b| a > b }
  visited = Set.new

  until queue.empty?
    state = queue.pop
    return state if state.source == TARGET
    next if visited.include? state
    visited.add(state)

    possible_moves[state.empty].each do |to|
      new_state = state.move(to).from(state)
      queue.push(new_state)
    end
  end
end

def adjecent_squares(x,y)
  [[x-1, y], [x+1, y], [x, y-1], [x, y+1]].select { |i,j|
    (0...WIDTH).cover?(i) && (0...HEIGHT).cover?(j)
  }
end

possible_moves = nodes.map { |(x,y), node|
  directions = adjecent_squares(x,y).select { |pos| other = nodes[pos]; node.size >= other.used }
  [[x,y], directions]
}.to_h

top_right = [WIDTH-1, 0]
empty_pos, _  = nodes.find { |_, node| node.used == 0 }

start = State.new(0, top_right, empty_pos)

f = search(start, possible_moves)
puts f.moves
