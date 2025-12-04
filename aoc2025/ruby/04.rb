#grid = File.readlines('../input-real04.txt').map { it.chomp.chars }
grid = File.readlines('../input-sample04.txt').map { it.chomp.chars }

removed = 0
total = 0

puts "Start"
puts
puts grid.map(&:join)

loop do
  grid = grid.each_with_index.map { |line,y|
    line.each_with_index.map { |cell,x|
      next cell if cell != '@'

      neighbours = 
        [[y-1,x-1], [y-1,x], [y-1,x+1],
         [y  ,x-1],          [y  ,x+1],
         [y+1,x-1], [y+1,x], [y+1,x+1]]

      n = neighbours.filter { |ny,nx|
        0 <= ny && ny < grid.length &&
        0 <= nx && nx < line.length
      }.count { |ny,nx|
        grid[ny][nx] == '@'
      }

      n < 4 ? 'x' : '@'
    }
  }

  removed = grid.map(&:join).join.count("x")
  total+=removed

  puts "\nRemoved #{removed} - total #{total}\n\n"
  break if removed == 0

  puts grid.map(&:join)

  grid.map! { |line| line.map { |char| char.sub("x",".") } }
end

