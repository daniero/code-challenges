require "set"
require "pqueue"

def read_map(file)
  points = {}
  coords = {}
  map = File.open(file).each_line.with_index.map do |line, y|
    line.chomp.each_char.with_index.map do |char, x|
      if char =~ /\d/
        coords[[x,y]] = char.to_i
        points[char.to_i] = [x,y]
      end
      char != "#"
    end
  end
  return map, points, coords
end

def find_distances(map, points, coords)
  distances = points.keys.map { |from| [from, {}] }.to_h

  points.each do |from, _|
    start = [points[from], 0] # [[x,y], moves]
    queue = [start]
    visited = Set.new

    until queue.empty?
      (x,y), moves = queue.shift
      next if visited.include?([x,y])
      visited.add([x,y])

      if (to = coords[[x,y]]) && (to != from)
        distances[from][to] = moves
        break if distances[from].size == points.size - 1
        next
      end

      possible_moves(x, y, map).each { |i,j| queue << [[i,j], moves+1] }
    end
  end

  distances
end

def possible_moves(x, y, map)
  [[x-1, y], [x+1, y], [x, y-1], [x, y+1]]
    .select { |i,j| (0...map.first.size).cover?(i) && (0...map.size).cover?(j) }
    .select { |i,j| map[j][i] }
end

State = Struct.new(:current, :visited, :distance, :path) do
  def priority
    [-distance, visited.size]
  end

  def possible_moves(graph)
    neighbours = graph[current]
    neighbours.map { |node, new_distance|
      State.new(node, visited + [node], distance + new_distance, path + [node])
    }
  end
end

def traveling_salesman(graph)
  start = State.new(0, Set[0], 0, [0])

  queue = PQueue.new([start]) { |a,b| (a.priority <=> b.priority) == 1 }
  visited = Set.new

  loop do
    state = queue.pop
    next if visited.include?([state.current, state.visited])
    return state if yield state

    visited.add([state.current, state.visited])
    state.possible_moves(graph).each { |new_state| queue.push(new_state) }
  end
end

# Part 1

map, points, coords = read_map('input/24.txt')
graph = find_distances(map, points, coords)
puts traveling_salesman(graph) { |state| state.visited.size == graph.size }

# Part 2
puts traveling_salesman(graph) { |state| state.visited.size == graph.size && state.current == 0 }
