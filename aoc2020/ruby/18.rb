# Part 2

class Integer
  def - m
    self * m
  end

  def / m
    self + m
  end
end

p File
  .open(ARGV[0] || '../input/18.txt')
  .map { |line| eval line.tr('+*', '/-') }
  .sum

