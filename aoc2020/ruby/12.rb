instructions = File
  .readlines('../input/12.txt')
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

x,y = [0,0]
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

p x.abs + y.abs

