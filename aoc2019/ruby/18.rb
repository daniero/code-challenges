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
    when starting_point, /[.@1234]/
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

State = Struct.new(:nodes, :keys, :steps)

def solve(graph, starting_points)
  total_keys = graph.keys.grep(/[a-z]/).length

  start = State.new(starting_points, Set[], 0)

  queue = PQueue.new([start]) { |a,b| a.steps < b.steps }
  visited = Set[]

  loop do
    current = queue.pop
    next unless visited.add?([current.nodes, current.keys])

    if current.keys.count == total_keys
      return current
    end

    current.nodes.each { |node|
      graph[node].each { |next_node, distance|
        is_door =  next_node.between?('A', 'Z')
        is_key = next_node.between?('a', 'z')

        next_nodes = current.nodes - [node] + [next_node]

        if is_door && current.keys.include?(next_node.downcase)
          queue << State.new(
            next_nodes,
            current.keys,
            current.steps + distance,
            #current.path + [next_node]
          )
        elsif is_key
          queue << State.new(
            next_nodes,
            current.keys + [next_node],
            current.steps + distance,
            #current.path + [next_node]
          )
        end
      }
    }
  end
end

def translate_map(map)
  points = {}
  map.each.with_index { |row,y|
    row.each.with_index { |c, x|
      points[c] = [x,y] if c =~ /[@1234A-z]/
    }
  }

  graph = {}
  points.each { |name, position|
    graph[name] = find_reachable_nodes(map, points, name)
  }

  return graph, points
end


map = File
  .readlines(ARGV[0] || '../input/input18.txt')
  .map(&:chomp)
  .map(&:chars)


graph, points = translate_map(map)

# Part 1
#solution = solve(graph, ['@'])
#p solution.steps

# Part 2
center_x, center_y = points['@']
map[center_y-1][center_x-1] = '1'
map[center_y-1][center_x+1] = '2'
map[center_y+1][center_x-1] = '3'
map[center_y+1][center_x+1] = '4'
map[center_y-1][center_x] = '#'
map[center_y][center_x-1] = '#'
map[center_y][center_x] = '#'
map[center_y][center_x+1] = '#'
map[center_y+1][center_x] = '#'
puts map.map(&:join)

#map = File
#  .read(ARGV[0] || '../input/input18.txt')
#  .gsub(/@/).with_index { |_,i| i + 1 }
#  .tap { |x| puts x }
#  .lines
#  .map(&:chomp)
#  .map(&:chars)

graph, points = translate_map(map)
pp points, graph

solution = solve(graph, %w[1 2 3 4])
p solution
puts
p solution.steps
