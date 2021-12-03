input =
  File
    .readlines('../input/03.txt')
    .map { |line| line.chomp.chars.map(&:to_i) }

def gamma(ns)
  ns
    .transpose
    .map { |c| c.count(0) > c.count(1) ? 0 : 1 }
end


# Part 1

gamma_rate = gamma(input).join.to_i(2)
epsilon_rate = (~gamma_rate)[0...gamma_rate.bit_length]

p gamma_rate * epsilon_rate


# Part 2

oxygen = input.dup
i = 0
until oxygen.length == 1
  g = gamma(oxygen)
  
  oxygen.reject! { |line| line[i] != g[i] }

  i += 1
end


scrubber = input.dup
i = 0
until scrubber.length == 1
  g = gamma(scrubber)
  
  scrubber.reject! { |line| line[i] == g[i] }

  i += 1
end


pp oxygen.join.to_i(2) * scrubber.join.to_i(2)

