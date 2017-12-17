INPUT = 363

# Part 1

array = [0]
pos = 0

2017.times do |i|
  pos = (pos + INPUT + 1) % array.length
  array[pos,0] = i+1
end

p array.rotate[pos]

# Part 2

len = 1
pos = 0
after_zero = nil

1.upto(50_000_000) do |i|
  pos = (pos + INPUT) % len
  after_zero = i if pos == 0
  len+= 1
  pos+= 1
end

p after_zero
