input = File
  .readlines('../input-sample03.txt')
 #.readlines('../input-real03.txt')
  .map { it.chomp.chars.map(&:to_i) }


def find_maximum_jolt(batteries, n)
  return batteries.max if n == 1

  max = batteries[0..(batteries.length-n)].max
  max_index = batteries.index(max)

  rest = batteries[max_index+1..-1]
  return max*10**(n-1) + find_maximum_jolt(rest, n-1)
end



p input.sum { |a|
  find_maximum_jolt(a, 2)
}

p input.sum { |a|
  find_maximum_jolt(a, 12)
}
