instructions = File
  .readlines(ARGV[0] || '../input/12.txt')
  .map { |line|
    raise "'#{line}'" unless line =~ /^([A-Z])(\d+)$/
    [$1, $2.to_i]
  }

DIRECTIONS = [
  [ 1, 0], # east
  [ 0, 1], # south
  [-1, 0], # west
  [ 0,-1], # north
]


# Part 1

x,y = [0, 0]
dir = 0

instructions.each do |inst, arg|
  case inst
  when 'R'
    dir += arg
  when 'L'
    dir -= arg
  when 'F'
    i, j = DIRECTIONS[dir / 90 % 4]
    x, y = x + i*arg, y + j*arg
  when 'E'
    x += arg
  when 'S'
    y += arg
  when 'W'
    x -= arg
  when 'N'
    y -= arg
  end
end

puts x.abs + y.abs


# Part 2

ship_x, ship_y = [0, 0]
waypoint_x, waypoint_y = [10, -1]

instructions.each do |inst, arg|
  case inst
  when 'R'
    (arg / 90).times { waypoint_x, waypoint_y = -waypoint_y, waypoint_x }
  when 'L'
    (arg / 90).times { waypoint_x, waypoint_y = waypoint_y, -waypoint_x }
  when 'F'
    ship_x += waypoint_x * arg
    ship_y += waypoint_y * arg
  when 'E'
    waypoint_x += arg
  when 'S'
    waypoint_y += arg
  when 'W'
    waypoint_x -= arg
  when 'N'
    waypoint_y -= arg
  end
end

puts ship_x.abs + ship_y.abs
