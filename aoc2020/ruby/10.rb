adapters = File
  .readlines('../input/10.txt')
  .map(&:to_i)
  .sort

outlet = 0
device = adapters.max + 3


# Part 1

jumps = [outlet, *adapters, device]
  .each_cons(2)
  .map { |a,b| b-a }
  .tally
  
p jumps[1] * jumps[3]


# Part 2

require 'set'
nodes = Set[outlet, *adapters, device]

paths = Hash.new { 0 }
paths[outlet] = 1

possible_jumps = [1, 2, 3]

[outlet, *adapters].each do |node|
  possible_jumps.each do |jump|
    target = node + jump
    if nodes.include? target
      paths[target] += paths[node]
    end
  end
end

p paths[device]
