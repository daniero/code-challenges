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
