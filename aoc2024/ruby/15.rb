require 'set'

DIRS = [[0,1], [1,0], [0,-1], [-1,0]]

def move!(grid, pos, dir)
  y,x = pos
  to_y,to_x = [pos,dir].transpose.map(&:sum)

  tile = grid[y][x]
  grid[y][x] = '.'
  grid[to_y][to_x] = tile
end

def move?(grid, pos, dir)
  to_y,to_x = [pos,dir].transpose.map(&:sum)
  to_tile = grid[to_y][to_x]

  case
  when to_tile == '#'
    return false

  when to_tile == 'O' || '[]'.include?(to_tile) && DIRS.values_at(0,2).include?(dir)
    return false unless move?(grid, [to_y,to_x], dir)

  when '[]'.include?(to_tile)
    return false unless moves = find_movable_big_boxes(grid, pos, dir)
    moves.uniq.sort_by { _1[0] * -dir[0] }.each { |box| move!(grid, box, dir) }
    return true
  end

  move!(grid, pos, dir)
  return true
end

def find_movable_big_boxes(grid, pos, dir, visited=Set[])
  return [] unless visited.add?(pos)

  y,x = pos
  dy = dir[0]
  to_y = y+dy

  to_tile = grid[to_y][x]

  return [] if to_tile == '.'
  return nil if to_tile == '#'

  case
  when to_tile == '['
    next_left_pos = [to_y, x]
    next_right_pos = [to_y, x+1]
  when to_tile == ']'
    next_left_pos = [to_y, x-1]
    next_right_pos = [to_y, x]
  end

  return nil unless cascade_left = find_movable_big_boxes(grid, next_left_pos, dir, visited)
  return nil unless cascade_right = find_movable_big_boxes(grid, next_right_pos, dir, visited)

  return [pos, next_left_pos, next_right_pos, *cascade_left, *cascade_right]
end

def gps_sum(map)
  map.each_with_index.sum do |row,y|
    row.each_char.with_index.sum do |c,x|
      case c
      when'O'
        y*100+x
      when'['
        dy = y <= map.length ? y : map.length - y
        dx = x < row.length ? x : row.length - x - 1
        dy*100+dx
      else
        0
      end
    end
  end
end

def run(map, moves)
  map = map.map(&:dup)
  pos, = map.filter_map.with_index { |row,y| row.index('@')&.then { |x| [y,x] } }

  moves.each_char do |c|
    dir = DIRS['>v<^'.index(c) || next]
    moved = move?(map, pos, dir)
    pos = [pos,dir].transpose.map(&:sum) if moved
  end

  return map
end

map, moves = File
  .read('../input/15.txt')
  .split("\n\n")
  .then { |a,o| [a.split, o.chomp] }

part1 = run(map, moves)
p gps_sum(part1)


large_map = map.map { _1
  .gsub('#','##')
  .gsub('O','[]')
  .gsub('.','..')
  .gsub('@','@.')
}

part2 = run(large_map, moves)
p gps_sum(part2)
