require 'set'

def neighbours(grid, x, y)
  [
    [x-1,y-1],
    [x,y-1],
    [x+1,y-1],
    [x-1,y],
    [x+1,y],
    [x-1,y+1],
    [x,y+1],
    [x+1,y+1],
  ].select { |x,y| y >= 0 && y < grid.length && x >= 0 && x < grid[y].length }
end

def inc!(grid, flashed, x, y)
  new_value = grid[y][x] += 1

  if new_value > 9 && flashed.add?([x,y])
    neighbours(grid, x, y).each { |nx,ny| inc!(grid, flashed, nx, ny) }
  end
end

def step!(octopi)
  flashed = Set[]

  octopi.each_with_index { |row, y|
    row.each_with_index { |octopus, x|
      inc!(octopi, flashed, x, y)
    }
  }

  octopi.each_with_index { |row, y|
    row.each_with_index { |octopus, x|
      octopi[y][x] = 0 if octopus > 9
    }
  }

  flashed.size
end


CLEAR_SCREEN = "\033[2J\033[H"
BOLD = "\u001b[1m"
RESET = "\u001b[0m"

def display(octopi)
  print CLEAR_SCREEN
  octopi.each { |row|
    row.each { |octopus|
      print octopus == 0 ? "#{BOLD}0#{RESET}" : octopus
    }
    puts
  }
  puts
end


input = File
  .readlines(ARGV[0] || '../input/11.txt')
  .map { _1.scan(/\d/).map(&:to_i) }


part = 2

if part == 1

  total_flashes = 0
  100.times do
    display(input)
    total_flashes += step!(input)
    sleep 0.08
  end

  display(input)
  p total_flashes

else

  1.step do |step|
    flashes = step!(input)
    display(input)
    print "steps: #{step}"

    sleep 0.08
    break if flashes == 100
  end
  puts
  puts

end
