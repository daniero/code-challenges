input = File
  .readlines('../input/04-sample.txt')
  .map { _1.chomp.chars }
  .map { |row| [?.]*3 + row + [?.]*3 }
  .then { [_1.first.map{?.}] * 3 + _1 + [_1.first.map{?.}] * 3 }
  
dirs = [
  [-1,-1], [-1,0], [-1,1],
  [ 0,-1],         [ 0,1],
  [ 1,-1], [ 1,0], [ 1,1],
]

# Part 1
p input.map.with_index.sum { |row,y|
  row.each_index.sum { |x|
    dirs.count { |v,u|
      input[y+u*0][x+v*0] == 'X' &&
      input[y+u*1][x+v*1] == 'M' &&
      input[y+u*2][x+v*2] == 'A' &&
      input[y+u*3][x+v*3] == 'S'
    }
  }
}

# Part 2
p input.map.with_index.sum { |row,y|
  row.map.with_index.count { |char,x|
    char == 'A' &&
    [input[y-1][x-1],input[y+1][x+1]].sort.join == 'MS' &&
    [input[y+1][x-1],input[y-1][x+1]].sort.join == 'MS'
  }
}
