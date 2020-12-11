FLOOR = '.'
EMPTY = 'L'
OCCUPIED = '#'

def tick(seats, occupied_threshold)
  seats.each_with_index.map { |row, y|
    row.each_with_index.map { |seat, x|
      next FLOOR if seat == FLOOR
      neighbours_occupied = yield(seats, x, y)
      next OCCUPIED if seat == EMPTY && neighbours_occupied == 0
      next EMPTY if seat == OCCUPIED && neighbours_occupied >= occupied_threshold
      seat
    }
  }
end

def find_stable_state(initial_state, occupied_threshold, &count_occupied_seats)
  prev_state = nil
  next_state = initial_state

  until prev_state == next_state
    prev_state, next_state = next_state, tick(next_state, occupied_threshold, &count_occupied_seats)
  end

  return next_state.sum { |row| row.count(OCCUPIED) }
end


# Part 1

DIRECTIONS = [
 [-1, -1], [0, -1], [+1, -1],
 [-1,  0],          [+1,  0],
 [-1, +1], [0, +1], [+1, +1]
]


initial_seats = File
  .read('../input/11.txt')
  .split("\n")
  .map(&:chars)


p find_stable_state(initial_seats, 4) { |state, x, y|
  DIRECTIONS
    .map { |i,j| [i+x, j+y] }
    .select { |i,j| j >= 0 && j < state.length && i >= 0 && i < state[j].length }
    .map { |i,j| state[j][i] }
    .count(OCCUPIED)
}


# Part 2


