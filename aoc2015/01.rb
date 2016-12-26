foo = File.read('input/01.txt')
  .chomp
  .each_char
  .map { |char| char == '(' ? 1 : -1 }

# Part 1
p foo.reduce(:+)

# Part 2
p foo
  .reduce([0]) { |a, f| a << a.last + f  }
  .each_with_index.find { |f, i| f < 0 }
  .last
