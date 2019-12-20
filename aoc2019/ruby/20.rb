require 'set'

def search_portal_name(map, x, y)
  return if y < 2 || y >= map.size - 2
  row = map[y]
  return if x < 2 || x >= row.size - 2
  [
    [map[y-2][x],map[y-1][x]],
    [map[y+1][x],map[y+2][x]],
    [map[y][x-2],map[y][x-1]],
    [map[y][x+1],map[y][x+2]],
  ]
    .map { |a,b| a+b }
    .grep(/[A-Z]{2}/)
    .first
end


map = File.readlines('../input/input20.txt').map { |line| line.chomp.chars }

portals = Hash.new { [] }
map.each.with_index { |line, linenum|
  line.each.with_index { |char, charnum|
    next unless char == '.'
    position = [charnum,linenum]
    portal = search_portal_name(map, charnum, linenum)
    portals[portal] = portals[portal] << position if portal
  }
}

jumps = portals
  .values
  .select { |locations| locations.size > 1 }
  .flat_map { |locations| [locations, locations.reverse] }
  .to_h

start, goal = portals.values_at('AA', 'ZZ').flatten(1)

initial = [start, 0]
queue = [initial]
visited = Set.new


until queue.empty? do
  position, steps = queue.shift
  next unless visited.add?(position)

  if position == goal
    p steps
    break
  end

  x,y = position
  queue += [
    [x,y-1],
    [x,y+1],
    [x-1,y],
    [x+1,y]
  ]
    .filter { |new_x, new_y| map[new_y][new_x] == '.' }
    .then { |positions| jumps[position] ? (positions << jumps[position]) : positions }
    .map { |position| [position, steps + 1] }
end
