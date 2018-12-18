grid = File
  .readlines('../input/input18.txt')
  .map(&:chomp)
  .map(&:chars)

def adjecent_squares(x,y, grid)
  [
    [x-1, y-1],
    [x, y-1],
    [x+1, y-1],
    [x-1, y],
    [x+1, y],
    [x-1, y+1],
    [x, y+1],
    [x+1, y+1]
  ]
    .select { |i,j| i >= 0 && i < grid[y].length && j >= 0 && j < grid.length }
    .map { |i,j| grid[j][i] }
end

10.times do
  grid = grid.map.with_index do |row, y|
    row.map.with_index do |cell, x|
      adjecent_squares = adjecent_squares(x,y, grid)
      case cell
      when '.'
        adjecent_squares.count('|') >= 3 ? '|' : '.'
      when '|'
        adjecent_squares.count('#') >= 3 ? '#' : '|'
      when '#'
        adjecent_squares.count('#') >= 1 &&
          adjecent_squares.count('|') >= 1 ? '#' : '.'
      end
    end
  end
end

flat = grid.flatten
p flat.count('#') * flat.count('|')
