input = File.readlines('../input/19-sample.txt', chomp: true)

patterns = input.first.split(", ")
designs = input.drop(2)


# Part 1
def part1(design, patterns)
  design.empty? || patterns.any? { |pattern|
    design.start_with?(pattern) && part1(design[pattern.length ..], patterns)
  }
end

p designs.count { part1(_1, patterns) }


# Part 2
$cache = {""=>1}

def part2(design, patterns)
  $cache[design] ||= patterns.sum { |pattern|
    next 0 unless design.start_with?(pattern)

    part2(design[pattern.length ..], patterns)
  }
end

p designs.sum { part2(_1, patterns) }
