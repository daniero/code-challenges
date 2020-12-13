a, b = File.readlines(ARGV[0] || '../input/13.txt')
start = a.to_i
bus_table = b.split(',').map(&:to_i)

buses = bus_table - [0]


# Part 1

p buses
  .map { |bus| [bus, bus-start%bus] }
  .min_by { |bus, wait| wait }
  .then { |bus, wait| bus*wait }
