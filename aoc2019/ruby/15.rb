require 'set'
require_relative 'intcode'

HitWall = 0
Moved = 1
FoundTarget = 2

North = 1
South = 2
West = 3
East = 4

def adjecent_squares((x,y))
  [
    [[x, y-1], North],
    [[x, y+1], South],
    [[x+1, y], East],
    [[x-1, y], West],
  ]
end

def move((x,y), direction)
  case direction
  when North
    [x,y-1]
  when South
    [x,y+1]
  when West
    [x-1,y]
  when East
    [x+1,y]
  end
end

def find_unexplored_square(start_position, explored_map)
  inital_state = [start_position, []]
  queue = [inital_state]
  searched = Set.new

  until queue.empty?
    position, path = queue.shift
    next unless searched.add?(position)

    return path unless explored_map.has_key?(position)

    adjecent_squares(position).each do |next_position,step|
      next if explored_map[next_position] == HitWall
      queue << [next_position, [*path,step]]
    end
  end

  return nil
end

def explore_map(program)
  movement_channel = Queue.new
  status_channel = Queue.new

  droid = IntcodeComputer.new(program, input: movement_channel, output: status_channel)

  Thread.new { droid.run }

  position = [0,0]
  map = {position => Moved}

  loop do
    path = find_unexplored_square(position, map)
    break unless path

    *backtracks, new_step = path

    backtracks.each do |step|
      movement_channel.push(step)
      response = status_channel.pop
      raise 'wtf' if response == HitWall
      position = move(position, step)
    end

    movement_channel.push(new_step)
    response = status_channel.pop

    new_position = move(position, new_step)
    map[new_position] = response
    position = new_position unless response == HitWall
  end

  return map
end

def find_distance(map, start_position, target)
  inital_state = [start_position, 0]
  queue = [inital_state]
  searched = Set.new

  until queue.empty?
    position, steps = queue.shift
    next unless searched.add?(position)

    return steps if position == target

    adjecent_squares(position).each do |next_position,step|
      next if map[next_position] == HitWall
      queue << [next_position, steps+1]
    end
  end
end

program = read_intcode('../input/input15.txt')

map = explore_map(program)
target = map.key(FoundTarget)
p find_distance(map, [0,0], target)


# Part 2

def find_max_distance(map, start_position)
  inital_state = [start_position, 0]
  queue = [inital_state]
  searched = Set.new
  max_distance = 0

  until queue.empty?
    position, steps = queue.shift
    next unless searched.add?(position)

    max_distance = steps if steps > max_distance

    adjecent_squares(position).each do |next_position,step|
      next if map[next_position] == HitWall
      queue << [next_position, steps+1]
    end
  end

  max_distance
end

p find_max_distance(map, target)
