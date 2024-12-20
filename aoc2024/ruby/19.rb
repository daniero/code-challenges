def make(design, patterns)
  design.empty? || patterns.any? { |pattern|
    design.start_with?(pattern) && make(design[pattern.length ..], patterns)
  }
end


input = File.readlines('../input/19-sample.txt', chomp: true)

patterns = input.first.split(", ")
designs = input.drop(2)

p designs.count { make(_1, patterns) }
