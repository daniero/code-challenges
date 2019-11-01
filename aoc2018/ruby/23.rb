Nanobot = Struct.new(:x, :y, :z, :range)

def distance(bot1, bot2)
  bot1.zip(bot2).take(3).sum { |a,b| (a-b).abs }
end

nanobots = File
  .open('../input/input23.txt')
  .each_line
  .map { |line| Nanobot.new(*line.scan(/-?\d+/).map(&:to_i)) }


#
# Part 1
#

max_bot = nanobots.max_by(&:range)
p nanobots.count { |bot| distance(bot, max_bot) <= max_bot.range }


#
# Part 2
#

Cube = Struct.new(:x, :y, :z, :size) do
  def split()
    half = size/2
    [x, x+half].product([y, y+half], [z, z+half])
      .map { |coords| Cube.new(*coords, half) }
  end
end

def in_range?(nanobot, cube)
  distance =
    distance2range(nanobot.x, cube.x, cube.size) +
    distance2range(nanobot.y, cube.y, cube.size) +
    distance2range(nanobot.z, cube.z, cube.size)

  nanobot.range >= distance
end

def distance2range(point, start, length)
    return 0 if point.between?(start, start+length-1)
    return [
      (start - point).abs,
      (point - start-length+1).abs
    ].min
end


# Define search space

def round_up_to_power_of_2(n)
  (n<=>0) * 2**Math.log2(n.abs).ceil
end

min_x = nanobots.map { |bot| bot.x - bot.range }.min
max_x = nanobots.map { |bot| bot.x + bot.range }.max
min_y = nanobots.map { |bot| bot.y - bot.range }.min
max_y = nanobots.map { |bot| bot.y + bot.range }.max
min_z = nanobots.map { |bot| bot.z - bot.range }.min
max_z = nanobots.map { |bot| bot.z + bot.range }.max
w = round_up_to_power_of_2(max_x - min_x)
h = round_up_to_power_of_2(max_y - min_y)
d = round_up_to_power_of_2(max_z - min_z)
cube_size = [w,h,d].max

complete_range = Cube.new(min_x, min_y, min_z, cube_size)


# Start search

require 'pqueue'

maxOverlap = 0
minDistanceForMaxOverlap = Float::INFINITY

init = [complete_range, nanobots.size ]

queue = PQueue.new([init]) { |a,b| a.last > b.last }

until queue.empty?
  cube, bots_in_range = queue.pop

  next if bots_in_range < maxOverlap

  if cube.size == 1
    distance = cube.x.abs + cube.y.abs + cube.z.abs

    if bots_in_range > maxOverlap
      maxOverlap = bots_in_range
      minDistanceForMaxOverlap = distance
    elsif bots_in_range == maxOverlap && distance < minDistanceForMaxOverlap
      minDistanceForMaxOverlap = distance
    end

  else
    cube.split.each { |new_cube|
      new_bots_in_range = nanobots.count { |bot| in_range?(bot, new_cube) }
      queue.push([new_cube, new_bots_in_range])
    }
  end
end

p minDistanceForMaxOverlap

