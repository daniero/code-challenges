INPUT = 33_100_000
n = INPUT / 10

# Part 1

houses = Array.new(n) { 0 }

(1...n).each do |i|
  (i...n).step(i).each do |j|
    houses[j]+= i
  end
end

p houses.index { |gifts| gifts*10 >= INPUT }


# Part 2

houses = Array.new(n) { 0 }

(1...n).each do |i|
  (i...n).step(i).take(50).each do |j|
    houses[j]+= i
  end
end

p houses.index { |gifts| gifts*11 >= INPUT }
