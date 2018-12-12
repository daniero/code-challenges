INPUT = 7315

def power_level(x, y, serial_numer=INPUT)
  rack_id = x + 10
  power_level = rack_id * y
  power_level+= serial_numer
  power_level*= rack_id
  power_level/= 100
  power_level%= 10
  power_level-= 5
end

def all_squares(square_size)
  squares = (1..300)
    .each_cons(square_size).to_a
    .repeated_permutation(2)
    .lazy
    .map { |a,b| a.product(b) }
end

def max_power_level(squares)
  squares.max_by { |square| square.sum { |x,y| power_level(x,y) } }
end

# Part 1
puts max_power_level(all_squares(3))
  .first
  .join(',')

# Part 2
# https://en.wikipedia.org/wiki/Summed-area_table

N = 300
summed_area = Array.new(N) { Array.new(N) }

N.times do |y|
  N.times do |x|
    sum_top = y == 0 ? 0 : summed_area[y-1][x]
    sum_left = x == 0 ? 0 : summed_area[y][x-1]
    sum_diagonal = x == 0 || y == 0 ? 0 : summed_area[y-1][x-1]
    current_value = power_level(x+1, y+1)

    summed_area[y][x] = sum_top + sum_left - sum_diagonal + current_value
  end
end

max_level = -9
max_square = []

(0...N).each do |y|
  (0...N).each do |x|
    max_size = N - [x,y].max

    (0...max_size).each do |size|
      topleft = summed_area[y][x]
      topright = summed_area[y][x+size]
      bottomleft = summed_area[y+size][x]
      bottomright = summed_area[y+size][x+size]

      power_level = topleft + bottomright - topright - bottomleft

      if power_level > max_level
        max_square = [x+2, y+2, size]
        max_level = power_level
      end
    end
  end
end

puts max_square.join(',')
