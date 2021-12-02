input =
  File
    .readlines('../input/02.txt')
    .map { |line|
      direction, length = line.split
      [direction, length.to_i]
    }

# Part 1

x,y = 0,0
input.each do |direction, length|
  case direction
  when 'up'; y-=length
  when 'down'; y+=length
  when 'forward'; x+=length
  else; raise 'nope'
  end
end

p x*y


# Part 2

x,y,aim = 0,0,0
input.each do |direction, length|
  case direction
  when 'up'
    aim -= length
  when 'down'
    aim += length
  when 'forward'
    x += length
    y += length * aim
  else
    raise 'nope'
  end
end

p x*y
