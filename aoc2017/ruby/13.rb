firewall = File.read('../input13.txt')
               .scan(/\w+/)
               .map(&:to_i)
               .each_slice(2)

# Part 1
p firewall
  .select { |depth,range| (depth) % (range*2-2) == 0 }
  .sum { |depth,range| depth * range }

# Part 2
p 1.step.find { |i|
  firewall.none? { |depth,range| (i + depth) % (range*2-2) == 0 }
}

