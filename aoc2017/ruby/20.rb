def distance(a,b,c)
  Math.sqrt(a**2 + b**2 + c**2)
end

input = File.readlines('../input20.txt')
  .map { |line| line.scan(/-?\d+/).map(&:to_i).each_slice(3).to_a }

# Part 1

p input
  .each_with_index
  .min_by { |((a,b,c),(d,e,f),(g,h,i)),_| [distance(g,h,i), distance(d,e,f), distance(a,b,c)] }
  .last

# Part 2

def update(particle)
  particle
    .transpose
    .map { |p,v,a| [p+v+a, v+a, a] }
    .transpose
end

def update_all(particles)
  tick = particles.map(&method(:update))
  groups = tick.group_by(&:first)
  tick.select { |particle| groups[particle.first].size == 1 }
end

100.times { input = update_all(input) }
p input.size
