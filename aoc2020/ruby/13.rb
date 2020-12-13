a, b = File.readlines(ARGV[0] || '../input/13.txt')
start = a.to_i
buses = b.scan(/\d+/).map(&:to_i)

p start, buses

p wait =
  buses
  .map { |bus| [bus, bus-start%bus] }
  .min_by { |bus, wait| wait }
  .then { |bus, wait| bus*wait }
