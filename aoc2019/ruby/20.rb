require 'set'

def search_portal_name(map, x, y)
  return if y < 2 || y >= map.size - 2
  row = map[y]
  return if x < 2 || x >= row.size - 2
  [
    [map[y-2][x],map[y-1][x], y == 2 ? :outer : :inner],
    [map[y+1][x],map[y+2][x], y == map.size - 3 ? :outer : :inner],
    [map[y][x-2],map[y][x-1], x == 2 ? :outer : :inner],
    [map[y][x+1],map[y][x+2], x == row.size - 3 ? :outer : :inner],
  ]
    .select { |a,b, _| a+b =~ /[A-Z]{2}/ }
    .map { |a,b, edge| [a+b, edge] }
    .first
end


map = File.readlines('../input/input20.txt').map { |line| line.chomp.chars }

start = nil
goal = nil

jumps = Hash.new
first_portals = Hash.new
map.each.with_index { |line, linenum|
  line.each.with_index { |char, charnum|
    next unless char == '.'
    position = [charnum,linenum]

    portal, edge = search_portal_name(map, charnum, linenum)
    next unless portal

    if portal == 'AA'
      start = position
    elsif portal == 'ZZ'
      goal = position
    elsif first_portals[portal]
      other_position = first_portals[portal]
      jumps[position] = [other_position, edge == :outer ? -1 : +1]
      jumps[other_position] = [position, edge == :outer ? +1 : -1]
    else
      first_portals[portal] = position
    end
  }
}


# Part 1

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
    .map { |new_position| [new_position, steps + 1] }

  jump, _ = jumps[position]
  if jump
    queue << [jump, steps + 1]
  end
end


# Part 2

initial = [start, 0, 0]
queue = [initial]
visited = Set.new

until queue.empty? do
  position, level, steps = queue.shift
  next unless visited.add?([*position, level])

  if position == goal && level == 0
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
    .map { |new_position| [new_position, level, steps + 1] }

  jump, level_change = jumps[position]
  if jump && (level_change == +1 || level > 0)
    queue << [jump, level + level_change, steps + 1]
  end
end
