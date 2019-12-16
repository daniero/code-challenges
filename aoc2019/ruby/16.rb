input = File.read('../input/input16.txt').chomp.chars.map(&:to_i)
base_pattern = [0, 1, 0, -1]

list = input

100.times do
  next_list = list.length.times.map { |i|
    list.each_with_index.sum { |x,j| x * base_pattern[(j+1)/(i+1)%4] }.abs % 10
  }
  list = next_list
end

puts list.take(8).join
