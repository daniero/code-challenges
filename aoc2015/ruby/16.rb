aunts =
  File.readlines('../input/16.txt')
  .map do |line|
    line.scan(/(\w+): (\d+)/)
      .map { |prop, count| [prop.to_sym, count.to_i] }
      .to_h
  end

sender = {
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

# Part 1

p aunts.index { |aunt|
  sender.all? { |prop, count|
    aunt[prop].nil? || aunt[prop] == count
  }
} + 1
