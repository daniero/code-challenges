input = File.read('../input/09-sample.txt').chomp

data = input.chars.each_with_index.flat_map { |char,i|
  n = char.to_i

  if i%2 == 0
    [i/2] * n
  else
    ['.'] * n
  end
}

puts data.join

head = 0
tail = data.length - 1

loop do
  head+=1 until data[head] == '.'
  tail-=1 while data[tail] == '.'
  break if head >= tail

  data[head], data[tail] = data[tail], data[head]
end

puts data.join
puts data.each_with_index.sum { |n,i| n == '.' ? 0 : n*i  }
