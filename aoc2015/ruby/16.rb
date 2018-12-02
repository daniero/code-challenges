aunts =
  File.readlines('../input/16.txt')
  .map do |line|
    line.scan(/(\w+): (\d+)/)
      .map { |prop, count| [prop.to_sym, count.to_i] }
      .to_h
  end

def find_aunt(sender, aunts)
  aunts.index { |aunt|
    sender.all? { |prop, count|
      aunt[prop].nil? || count === aunt[prop]
    }
  } + 1
end


# Part 1
sender1 = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}
p find_aunt(sender1, aunts)

# Part 2
sender2 = {
  children: 3,
  cats: (8..100),
  samoyeds: 2,
  pomeranians: (0...3),
  akitas: 0,
  vizslas: 0,
  goldfish: (0...5),
  trees: (4..100),
  cars: 2,
  perfumes: 1,
}
p find_aunt(sender2, aunts)
