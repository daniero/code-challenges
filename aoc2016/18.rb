input = File.read('input/18.txt').chomp.chars.map { |c| c == '^' }

def trap?(left, center, right)
  left && center && !right ||
    !left && center && right ||
    left && !center && !right ||
    !left && !center && right
end

def next_row(row)
  [false, *row, false]
    .each_cons(3)
    .map { |left, center, right| trap?(left, center, right) }
end

def generate_floor(first_row, row_count=40)
  (1...row_count).reduce([first_row]) { |rows, _| rows << next_row(rows.last) }
end

# Part 1
puts generate_floor(input, 40).flatten.count(false)

# Part 1
puts generate_floor(input, 400_000).flatten.count(false)
