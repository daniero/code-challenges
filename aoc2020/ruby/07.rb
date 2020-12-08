bags = File
  .readlines('../input/07.txt')
  .map { |line|
    bag = line[/^(\w+ \w+)/]
    content = line
      .scan(/(\d+) (\w+ \w+)/)
      .map { |num, name| [num.to_i, name] }

    [bag, content]
  }.to_h

  
TARGET = 'shiny gold'


# Part 1

def bags.can_hold?(outter_bag)
  inner_bags = self[outter_bag].map(&:last)

  inner_bags.any? { |inner_bag| inner_bag == TARGET } ||
  inner_bags.any? { |inner_bag| can_hold?(inner_bag) }
end

p bags.keys.count { |bag| bags.can_hold?(bag) }


# Part 2

def bags.count_inner_bags(outter_bag)
  content = self[outter_bag]

  content.sum { |number, inner_bag|
    number + number * count_inner_bags(inner_bag)
  }
end

p bags.count_inner_bags(TARGET)
