# Part 2

class Integer
  alias :- :*
  alias :/ :+
end

p File
  .open(ARGV[0] || '../input/18.txt')
  .sum { |line| eval line.tr('+*', '/-') }

