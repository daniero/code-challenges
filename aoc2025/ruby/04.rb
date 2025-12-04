#input = File.readlines('../input-real04.txt').map { it.chomp.chars }
input = File.readlines('../input-sample04.txt').map { it.chomp.chars }

puts q = input.each_with_index.map { |line,y|
  line.each_with_index.map { |cell,x|
    next cell if cell != '@'

    neighbours = 
      [[y-1,x-1], [y-1,x], [y-1,x+1],
       [y  ,x-1],          [y  ,x+1],
       [y+1,x-1], [y+1,x], [y+1,x+1]]

    n = neighbours.filter { |ny,nx|
      0 <= ny && ny < input.length &&
      0 <= nx && nx < line.length
    }
    .count { |ny,nx|
      input[ny][nx] == '@'
    }

    n < 4 ? 'x' : '@'
  }.join
}

p q.join.count("x")
