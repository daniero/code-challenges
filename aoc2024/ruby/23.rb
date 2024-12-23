require 'set'

input = File
  .readlines('../input/23-sample.txt', chomp: true)
  .map { _1.split('-') }

connections = Hash.new { Set[] }
input.each { |a,b|
  connections[a] += [b]
  connections[b] += [a]
}


# Part 1
ticc = Set[] # (three inter-connected computers)

connections.each { |cmp,cons|
  cons.each { |con|
    a = cons - [con]
    b = connections[con] - [cmp]

    (a&b).each { ticc << [cmp, con, _1].sort }
  }
}

p ticc
  .filter { |set| set.any? { _1.start_with? 't' } }
 #.tap { |sets| puts sets.sort.map { _1.join ',' } }
  .size


# Part 2
subsets = [[]]

connections.each { |cmp,cons|
  new_subsets = []
  subsets.each { |subset|
    if subset.all? { cons.include? _1 }
      new_subsets << subset + [cmp]
    end
  }
  subsets += new_subsets
}

puts subsets.max_by(&:size).sort.join(',')
