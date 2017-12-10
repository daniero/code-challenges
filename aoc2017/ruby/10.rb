input = File.read('../input10.txt').split(',').map(&:to_i)

list = [*0..255]
n = list.size
position = 0
skip = 0


input.each do |length|
  range = position ... position+length
  idx = range.map { |i| i % n }
  sublist = list.values_at(*idx)

  sublist.reverse.zip(idx).each { |e,i| list[i] = e }

  position = (position+length+skip) % n
  skip += 1
end

puts list[0] * list[1]
