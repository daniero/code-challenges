input = File.readlines('../input/input12.txt')

initial = input.first[/[#.]+/]
pots = Hash.new { '.' }
initial.chars.each_with_index { |v,i| pots[i] = v }

rules = input
  .drop(2)
  .map { |line| line.scan(/[#.]+/) }
  .to_h
rules.default = '.'

20.times do
  next_generation = Hash.new { '.' }
  first, last = pots.keys.minmax

  (first-3..last+3).each_cons(5) do |x|
    y = pots.values_at(*x).join
    next_generation[x[2]] = rules[y]
  end

  pots = next_generation
end

puts pots.sum { |k,v| v == '#' ? k : 0 }
