require_relative 'room'
require 'set'

def generate_maze(input)
  start = Room[0,0]
  map_rooms(input, [start])
  start
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
      current_rooms, cursor = map_rooms(input, current_rooms, cursor+1)
    when ')', '$', nil
      next_rooms.merge(current_rooms)
      return next_rooms, cursor
    else
      current_rooms.map! { |room| room.connect(char) }
    end

    cursor += 1
  end
end
