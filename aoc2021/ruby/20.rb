
Grid = Struct.new(:rows, :inf_state) do
  def neighbours(x,y)
    [
      [x-1,y-1], [x,y-1], [x+1,y-1],
      [x-1,y], [x,y], [x+1,y],
      [x-1,y+1], [x,y+1], [x+1,y+1],
    ]
      .map { |x,y|
        if y < 0 || y >= rows.size || x < 0 || x >= rows[y].size
          inf_state 
        else
          rows[y][x]
        end
      }
  end
end

def step(grid, rules)
  size = grid.rows.size

  next_cells =
    (-1 .. size).each_with_index.map { |y|
      (-1 .. size).each_with_index.map { |x|
        rules[grid.neighbours(x,y).join.to_i(2)]
      }
    }
  inf_state = rules[-grid.inf_state]
  Grid.new(next_cells, inf_state)
end

input = File.read('../input/20.txt').split("\n\n")
rules = input[0].chars.map { ".#".index _1 }
grid = Grid.new(input[1].lines.map { |line| line.chomp.chars.map { |c| ".#".index c } }, 0)

2.times do
  grid = step(grid, rules)
end

p grid.rows.sum { |row| row.sum }

48.times do
  grid = step(grid, rules)
end

p grid.rows.sum { |row| row.sum }
