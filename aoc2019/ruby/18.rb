require 'set'
require 'pqueue'

def find_reachable_nodes(map, points, starting_point)
  start_position = points[starting_point]
  queue = [[start_position, 0]]
  visited = Set[]
  found_nodes = {}

  until queue.empty?
    position, steps = queue.shift
    next unless visited.add?(position)

    x,y = position
    case map[y][x]
    when starting_point, '.', '@'
      queue << [[x+1,y], steps+1]
      queue << [[x-1,y], steps+1]
      queue << [[x,y+1], steps+1]
      queue << [[x,y-1], steps+1]
    when /[@A-Za-z]/
      found_nodes[$&] ||= steps
    end
  end

  found_nodes
end

State = Struct.new(:node, :keys, :steps, :path)

def solve(graph)
  total_keys = graph.keys.grep(/[a-z]/).length

  start = State.new('@', Set[], 0, [])
  queue = PQueue.new([start]) { |a,b| a.steps < b.steps }
  visited = Set[]

  loop do
    current = queue.pop
    next unless visited.add?([current.node, current.keys])

    if current.keys.count == total_keys
      return current
    end

    graph[current.node].each { |node, distance|
      is_door =  node >= 'A' && node <= 'Z'
      is_key = node >= 'a'

      queue << State.new(node, current.keys, current.steps + distance, current.path + [node]) if is_door && current.keys.include?(node.downcase)
      queue << State.new(node, current.keys + [node], current.steps + distance, current.path + [node]) if is_key
    }
  end
end

def read_graph(filename)
  map = File
    .readlines(filename)
    .map(&:chomp)
    .map(&:chars)

  points = {}
  map.each.with_index { |row,y|
    row.each.with_index { |c, x|
      points[c] = [x,y] if c =~ /[@A-z]/
    }
  }

  graph = {}
  points.each { |name, position|
    graph[name] = find_reachable_nodes(map, points, name)
  }
  graph
end


graph = read_graph(ARGV[0] || '../input/input18.txt')
solution = solve(graph)
p solution.steps
