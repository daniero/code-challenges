FILE = 'input\15.txt'

input = File.open(FILE).each_line.map do |line|
  line =~ /Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+)./
  positions, start = [$1, $2].map(&:to_i)
end

def find_time(disks)
  x = 1.step.find { |time|
    disks.each_with_index.all? { |(positions, start), i|
      current = (start + time + i) % positions
      current == 0
    }
  }
  x - 1
end

# Part 1
p find_time(input)

# Part 2
p find_time(input + [[11, 0]])
