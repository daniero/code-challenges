INPUT = '10011111011011001'.chars.map(&:to_i)
FILL_LENGTH1 = 272
FILL_LENGTH2 = 35651584

def pad_data(initial, length)
  padded = initial + [0] + initial.reverse.map { |i| i^1 }
  padded.length < length ? pad_data(padded, length) : padded
end

def checksum(data, length)
  data = data.take(length)
  check = data.each_slice(2).map { |a,b| a == b ? 1 : 0 }
  check.length.even? ? checksum(check, length) : check
end

def solve(input, length)
  padded_data = pad_data(input, length)
  checksum(padded_data, length)
end

puts solve(INPUT, FILL_LENGTH1).join
puts solve(INPUT, FILL_LENGTH2).join
