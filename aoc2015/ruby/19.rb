require 'set'

lines = File.readlines('../input/19.txt').map(&:chomp)

replacements = Hash.new { |h, k| h[k] = [] }
lines
  .take_while { |line| !line.empty? }
  .flat_map { |line| line.scan /(\w+) => (\w+)/ }
  .each { |from, to| replacements[from] << to }

medicine = lines.last

def new_molecules(molecule, replacements)
  molecules_found = Set.new

  replacements.each do |from, to|
    to.each do |replacement|
      molecule.scan(from) { molecules_found << "#$`#{replacement}#$'" }
    end
  end

  molecules_found
end

# Part 1:

p new_molecules(medicine, replacements).size


# Part 2:

def find(target, initial, replacements)
  queue = [ [initial, 0] ]

  until queue.empty? do
    molecule, steps = queue.pop

    new_molecules(molecule, replacements).reverse_each do |new_molecule|
      if new_molecule == target
        return steps + 1
      end

      queue.push [new_molecule, steps+1]
    end
  end
end

inverted_replacements = Hash.new { |h, k| h[k] = [] }
replacements.each do |from, to|
  to.each { |replacement| inverted_replacements[replacement] << from }
end

p find("e", medicine, inverted_replacements)
