input =
  File
    .readlines('../input/03.txt')
    .map { |line| line.chomp.chars.map(&:to_i) }

gamma_rate =
  input
    .transpose
    .map { |c| c.count(0) > c.count(1) ? 0 : 1 }
    .join.to_i(2)

epsilon_rate = ~gamma_rate & ~(-1 << gamma_rate.bit_length)

p gamma_rate * epsilon_rate
