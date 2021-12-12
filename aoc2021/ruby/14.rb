f = File.open('../input/14.txt')
template = f.gets
insertion_rules = f.read.scan(/(..)(?: -> )(.)/).to_h

pairs = template.chars.each_cons(2).tally
pairs.default = 0

40.times do
  next_pairs = {}
  next_pairs.default = 0

  pairs.each { |(a,b),tally|
    i = insertion_rules[a+b] || '?'

    next_pairs[[a,i]] += tally
    next_pairs[[i,b]] += tally
  }
  pairs = next_pairs
end

totals = {}
totals.default = 0
pairs.each { |(a,b),tally| totals[a] += tally }

p totals.values.minmax.reduce(:-).abs
