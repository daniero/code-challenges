FILE = 'input\15.txt'

input = File.open(FILE).each_line.map do |line|
  line =~ /Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+)./
  positions, start = [$1, $2].map(&:to_i)
end

x = 1.step.find { |time|
  input.each_with_index.all? { |(positions, start), i|
    current = (start + time + i) % positions
    current == 0
  }
}

p x - 1
