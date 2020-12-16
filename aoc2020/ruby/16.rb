a, b, c = File.read('../input/16.txt').split("\n\n")

fields = a
  .scan(/(\w+): (\d+)-(\d+) or (\d+)-(\d+)/)
  .map { |name, i,j,k,l| [name, [i.to_i..j.to_i, k.to_i..l.to_i]] }
  .to_h

my_ticket = b.scan(/\d+/).map(&:to_i)

nearby_tickets = c
  .lines
  .drop(1)
  .map { |line| line.scan(/\d+/).map(&:to_i) }


# Part 1

p nearby_tickets
  .flatten
  .select { |value| fields.values.flatten.none? { |field| field.include? value } }
  .sum
