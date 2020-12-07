bags = File
  .readlines('../input/07.txt')
  .map { |line|
    container = line[/^(\w+ \w+)/]
    containees = line.scan(/(\d+) (\w+ \w+)/)
    [container, containees]
  }.to_h

  
def can_hold?(container, target, all_bags)
  bag = all_bags[container].map(&:last)
  return false unless bag

  bag.any? { |containee| containee == target } ||
  bag.any? { |other| can_hold?(other, target, all_bags) }
end

p bags.keys.count { |bag| can_hold?(bag, 'shiny gold', bags) }


