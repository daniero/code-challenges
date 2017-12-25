def redistribute_max(input)
  blocks = input.dup

  max = blocks.max
  max_index = blocks.index max
  n = blocks.size

  blocks[max_index] = 0
  max.times { |i| blocks[(max_index+i+1)%n] += 1 }

  blocks
end

input = File.open('../input/input06.txt').read.split.map(&:to_i)

visited = {}
next_block = input
n = 0

until visited.include? next_block
  visited[next_block] = n
  next_block = redistribute_max(next_block)
  n += 1
end

# Part 1
p n

# Part 2
first_seen = visited[next_block]
p n - first_seen
