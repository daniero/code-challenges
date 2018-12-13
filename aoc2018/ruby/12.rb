def next_generation(pots, rules)
  next_generation = Hash.new { '.' }
  first, last = pots.keys.minmax

  (first-3..last+3).each_cons(5) do |x|
    y = pots.values_at(*x).join
    next_generation[x[2]] = rules[y]
  end

  # puts next_generation.values_at(*-3..next_generation.keys.max).join
  next_generation
end

input = File.readlines('../input/input12.txt')

initial = input.first[/[#.]+/]
pots = Hash.new { '.' }
initial.chars.each_with_index { |v,i| pots[i] = v }

rules = input
  .drop(2)
  .map { |line| line.scan(/[#.]+/) }
  .to_h
rules.default = '.'

# Part 1

20.times { pots = next_generation(pots, rules) }
puts pots.sum { |k,v| v == '#' ? k : 0 }

# Part 2

def trim(pots)
  pots
    .drop_while { |_, pot| pot == '.'  }
    .reverse
    .drop_while { |_, pot| pot == '.'  }
    .reverse
    .to_h
end

first_loop = 21.step.find do
  old_values = trim(pots).values.join
  pots = next_generation(pots, rules)
  new_values = trim(pots).values.join

  old_values == new_values
end

N = 50_000_000_000

generations_left = N - first_loop

p pots
  .select { |_, pot| pot == '#' }
  .sum { |index, _| index + generations_left }
