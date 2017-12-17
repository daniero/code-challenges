INPUT = 363

array = [0]
pos = 0

2017.times do |i|
  pos = (pos + INPUT + 1) % array.length
  array[pos,0] = i+1
end

p array.rotate[pos]
