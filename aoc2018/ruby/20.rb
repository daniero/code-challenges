require 'set'

class Room
  @@rooms = Hash.new { |h,(x,y)| h[[x,y]] = Room.new(x,y) }

  def self.[](x,y)
    @@rooms[[x,y]]
  end

  def self.rooms
    Hash.new.merge(@@rooms)
  end

  def self.clear
    @@rooms.clear
  end

  def initialize(x=0, y=0)
    @x,@y = x,y
    @connected = Hash.new { |h,dir| h[dir] = @@rooms[coordinates_to(dir)] }
  end

  def coordinates_to(direction)
    case direction
    when 'N'
      [@x, @y-1]
    when 'E'
      [@x+1, @y]
    when 'S'
      [@x, @y+1]
    when 'W'
      [@x-1, @y]
    else
      raise "invalid direction: '#{direction}'"
    end
  end

  def connect(direction, connect_other=true)
    other_room=@connected[direction]

    if (connect_other)
      opposite_direction = {?N=>?S, ?S=>?N, ?E=>?W, ?W=>?E}[direction]
      other_room.connect(opposite_direction, false)
    end

    other_room
  end

  def connected?(direction)
    @connected.has_key?(direction)
  end

  def go(direction)
    if connected?(direction)
      @connected[direction]
    end
  end

  def coords
    [@x,@y]
  end
end

def map_rooms(input, start_rooms, cursor=1)
  current_rooms = start_rooms.dup
  next_rooms = Set[]

  loop do
    case char = input[cursor]
    when '|'
      next_rooms.merge(current_rooms)
      current_rooms = start_rooms.dup
    when '('
      current_rooms, skip = map_rooms(input, current_rooms, cursor+1)
      cursor = skip
    when ')', '$', nil
      next_rooms.merge(current_rooms)
      return next_rooms, cursor
    else
      current_rooms.map! { |room| room.connect(char) }
    end

    cursor += 1
  end
end


filename =
  ARGV[0] &&
  "../input/input20-#{ARGV[0]}.txt" ||
  "../input/input20.txt"
input = File.read(filename).chomp

start_room = Room[0,0]
map_rooms(input, [start_room], 1)


queue = [ [start_room, 0] ]
visited = Set[]

until queue.empty? do
  room, distance = queue.shift
  next unless visited.add?(room.coords)

  %w[N S E W]
    .select { |dir| room.connected?(dir) }
    .each { |dir| queue << [room.go(dir), distance+1] }
end

p distance - 1
