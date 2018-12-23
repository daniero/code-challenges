# DEPTH = 10647
# TARGET = [7, 770]
DEPTH = 510
TARGET = [10, 10].freeze

REGION_TYPES = [:rocky, :wet, :narrow]
Region = Struct.new(:erosion_level, :type)

area = Hash.new do |hash,(x,y)|
  geologic_index =
    if [x,y] == [0,0] || [x,y] == TARGET
      0
    elsif y == 0
      x * 16807
    elsif x == 0
      y * 48271
    else
      hash[[x, y-1]].erosion_level *
      hash[[x-1, y]].erosion_level
    end

  erosion_level = (geologic_index + DEPTH) % 20183
  type = REGION_TYPES[erosion_level % 3]

  hash[[x,y]] = Region.new(erosion_level, type)
end

# Part 1

x,y = TARGET
p (0..x).sum { |i| (0..y).sum { |j| REGION_TYPES.index(area[[i,j]].type) } }

# Part 2

def adjecent_squares(x, y)
  Enumerator.new do |yielder|
    yielder << [x, y-1] if y > 0
    yielder << [x-1, y] if x > 0
    yielder << [x+1, y]
    yielder << [x, y+1]
  end
end

EQUIPMENT = [:climbing_gear, :torch, :neither]
USAGE = {
  rocky: [:climbing_gear, :torch],
  wet: [:climbing_gear, :neither],
  narrow: [:torch, :neither]
}

require 'set'
require 'pqueue'

def distance((x,y), (i,j))
  (x-i).abs + (y-j).abs
end

def search(area)
  initial = [0, 0, :torch, 0, 0]

  visited = Set[]
  queue = PQueue.new([initial]) { |(x1,y1,_,time1, s1),(x2,y2,_,time2, s2)| time1 < time2 }

  until queue.empty?
    x, y, equipment, time, steps = queue.pop

    # print "\r #{'%4s'%time} (#{'%3s'%x},#{'%3s'%y}) #{queue.size} #{visited.size}       "

    return time, queue, visited if [x, y, equipment] == [*TARGET, :torch]
    next unless visited.add? [x, y, equipment]

    region_type = area[[x,y]].type
    change,_ = USAGE[region_type] - [equipment]

    queue << [x, y, change, time + 7, steps+1]

    adjecent_squares(x,y).each do |new_x, new_y|
      region = area[[new_x, new_y]].type

      if USAGE[region].include?(equipment)
        queue << [new_x, new_y, equipment, time + 1, steps+1]
      end
    end

  end
end

time, queue, visited = search(area)
p [time, queue.size, visited.size]

