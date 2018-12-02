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
