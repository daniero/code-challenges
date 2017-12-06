def redistribute_max(input)
  blocks = input.dup

  max = blocks.max
  i = blocks.index max
  n = blocks.size

  blocks[i] = 0
  max.times {
    i+=1
    blocks[i%n]+=1
  }

  blocks
end

input = File.open('../input06.txt').read.split.map(&:to_i)

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
