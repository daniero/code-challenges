require 'set'

def distribute(input)
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

visited = Set.new
next_block = input
n = 0

loop do
  break if visited.include? next_block
  n += 1
  visited << next_block

  next_block = distribute(next_block)
end

p distribute(input)
p visited
p n
