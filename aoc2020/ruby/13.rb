a, b = File.readlines(ARGV[0] || '../input/13.txt')
start = a.to_i
bus_table = b.split(',').map(&:to_i)

buses = bus_table - [0]


# Part 1

p buses
  .map { |bus| [bus, bus-start%bus] }
  .min_by { |bus, wait| wait }
  .then { |bus, wait| bus*wait }


# Part 2

buses_with_index = buses
  .sort
  .reverse
  .map { |bus|
    i = bus_table.index(bus)
    idx = (bus - i) % bus
    [bus, idx]
  }

t = 1
s = 1

buses_with_index.each do |id, idx|
  t += s until t % id == idx
  s *= id
end

puts t
