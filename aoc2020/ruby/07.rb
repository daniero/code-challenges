bags = File
  .readlines('../input/07.txt')
  .map { |line|
    container = line[/^(\w+ \w+)/]
    containees = line.scan(/(\d+) (\w+ \w+)/)
    [container, containees]
  }.to_h


# Part 1

def can_hold?(container, target, all_bags)
  bag = all_bags[container].map(&:last)
  return false unless bag

  bag.any? { |containee| containee == target } ||
  bag.any? { |other| can_hold?(other, target, all_bags) }
end

p bags.keys.count { |bag| can_hold?(bag, 'shiny gold', bags) }


# Part 2

def must_hold(bag, all_bags)
  content = all_bags[bag]

  content.sum { |number, name|
    number.to_i + number.to_i * must_hold(name, all_bags)
  }
end

p must_hold('shiny gold', bags)
