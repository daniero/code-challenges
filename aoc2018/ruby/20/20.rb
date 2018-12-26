require_relative 'maze'
require 'set'

filename =
  ARGV[0] &&
  "../../input/input20-#{ARGV[0]}.txt" ||
  "../../input/input20.txt"
input = File.read(filename).chomp

start = generate_maze(input)


queue = [ [start, 0] ]
visited = Set[]
far_away = 0

until queue.empty? do
  room, distance = queue.shift
  next unless visited.add?(room.coords)

  far_away += 1 if distance >= 1000

  %w[N S E W]
    .select { |dir| room.connected?(dir) }
    .each { |dir| queue << [room.go(dir), distance+1] }
end

p distance - 1
p far_away
