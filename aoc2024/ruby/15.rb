DIRS = [[0,1], [1,0], [0,-1], [-1,0]]

def move(grid, pos, dir)
  to_y,to_x = [pos,dir].transpose.map(&:sum)
  to_tile = grid[to_y][to_x]

  return false if to_tile == '#'
  return false if to_tile == 'O' && !move(grid, [to_y,to_x] ,dir)
     
  y,x = pos
  tile = grid[y][x]
  grid[y][x] = '.'
  grid[to_y][to_x] = tile

  return true
end


map,moves = File
  .read('../input/15.txt')
  .split("\n\n")
  .then { |a,o| [a.split, o.chomp] }

pos, = map.filter_map.with_index { |row,y| row.index('@')&.then { |x| [y,x] } }

#puts map
#puts

moves.each_char do |c|
  dir = DIRS['>v<^'.index(c) || next]
  moved = move(map, pos, dir)
  pos = [pos,dir].transpose.map(&:sum) if moved

  #p [c,pos,dir,moved]
  #puts map
  #puts
end

p map.each_with_index.sum { |row,y|
  row.each_char.with_index.sum { |c,x| c == 'O' ? y*100+x : 0 }
}
