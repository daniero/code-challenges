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

squares = (1..300)
  .each_cons(3).to_a
  .repeated_permutation(2)
  .map { |a,b| a.product(b) }

puts squares
  .max_by { |square| square.sum { |x,y| power_level(x,y) } }
  .first
  .join(',')
