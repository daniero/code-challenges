initial_seats = File
  .read('../input/11.txt')
  .split("\n")
  .map(&:chars)

def neighbours(map, x, y)
  [
   [x-1, y-1], [x, y-1], [x+1, y-1],
   [x-1, y  ],           [x+1, y  ],
   [x-1, y+1], [x, y+1], [x+1, y+1]
  ]
    .select { |i,j| j >= 0 && j < map.length && i >= 0 && i < map[j].length }
    .map { |i,j| map[j][i] }
end

FLOOR = '.'
EMPTY = 'L'
OCCUPIED = '#'

def tick(seats)
  seats.each_with_index.map { |row, y|
    row.each_with_index.map { |seat, x|
      next FLOOR if seat == FLOOR
      neighbours_occupied = neighbours(seats, x, y).count(OCCUPIED)
      next OCCUPIED if seat == EMPTY && neighbours_occupied == 0
      next EMPTY if seat == OCCUPIED && neighbours_occupied >= 4
      seat
    }
  }
end

prev = nil
next_round = initial_seats

until prev == next_round
  print '.'
  prev, next_round = next_round, tick(next_round)
end

puts
p next_round.sum { |row| row.count(OCCUPIED) }
