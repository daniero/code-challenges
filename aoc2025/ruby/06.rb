p File
  .readlines('../input-real06')
  .map { |line| line.split }
  .transpose
  .sum { |*numbers, operator|
    numbers.map(&:to_i).reduce(&operator.to_sym)
  }
