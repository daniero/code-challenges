INPUT = '10011111011011001'.chars.map(&:to_i)
FILL_LENGTH = 272

def fill_data(initial, length)
  fill = initial + [0] + initial.reverse.map { |i| i^1 }
  fill.length < length ? fill_data(fill, length) : fill
end

def checksum(data)
  data = data.take(FILL_LENGTH)
  check = data.each_slice(2).map { |a,b| a == b ? 1 : 0 }
  check.length.even? ? checksum(check) : check
end

checksum = checksum(fill_data(INPUT, FILL_LENGTH))

puts checksum.join
