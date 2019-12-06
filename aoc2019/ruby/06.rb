orbits = Hash.new { |h,k| h[k] = [] }

File
  .readlines('../input/input06.txt')
  .each { |line|
    orbitee, orbiter = line.chomp.split(')')
    orbits[orbitee] << orbiter
  }

def count_orbits(orbits, node, subtotal = 0)
  children = orbits[node]
  subtotal +
    children.sum { |child| count_orbits(orbits, child, subtotal+1) }
end

p count_orbits(orbits, 'COM')
