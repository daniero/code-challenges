input = File
  .readlines(ARGV[0] || '../input/12.txt')
  .map { _1.scan(/\w+/) }

connections = Hash.new { |h,k| h[k] = [] }
input.each { |a,b|
  connections[a] << b
  connections[b] << a
}

pp connections


# Part 1

require 'set'

initial = [['start'], Set['start']]
queue = [initial]
paths_found = 0

until queue.empty?
  current_path, visited = queue.pop
  
  connections[current_path.last].each { |next_cave|
    if next_cave == 'end'
      paths_found += 1
      next
    end

    no_return = next_cave == next_cave.downcase

    if no_return && visited.include?(next_cave)
      next
    end

    new_visited = no_return ? visited.dup.add(next_cave) : visited
    new_path = [*current_path, next_cave]

    queue << [new_path, new_visited]
  }
end

puts "\nPart 1: #{paths_found}"


# Part 2

initial = [['start'], Set['start'], nil]
queue = [initial]
paths_found = 0

until queue.empty?
  current_path, visited, twice = queue.pop
  
  connections[current_path.last].each { |next_cave|
    next if next_cave == 'start'

    if next_cave == 'end'
      paths_found += 1
      next
    end

    no_return = next_cave == next_cave.downcase
    visited_current = no_return && visited.include?(next_cave)

    if visited_current
      next if twice
      new_twice = next_cave
    else
      new_twice = twice
    end

    new_visited = no_return ? visited.dup.add(next_cave) : visited
    new_path = [*current_path, next_cave]

    queue << [new_path, new_visited, new_twice]
  }
end

puts "Part 2: #{paths_found}"
