asteroids = File
  .open('../input/input10.txt')
  .each_line
  .with_index
  .flat_map { |line, linenum|
    line
      .each_char
      .with_index
      .flat_map { |char, charnum|
        char == '#' ?  [[charnum, linenum]] : []
      }
  }

def angle_between(x1, y1, x2, y2)
  Math.atan2(x2-x1, -(y2-y1)) % (2*Math::PI)
end

def distance_between(x1, y1, x2, y2)
  Math.sqrt((x1-x2)**2 + (y1-y2)**2)
end


location, lines_of_sight = asteroids
  .map { |asteroid|
    others = asteroids - asteroid
    lines = others.group_by { |other| angle_between(*asteroid, *other) }
    [asteroid, lines]
  }
  .max_by { |_, lines| lines.size }

p lines_of_sight.size

p lines_of_sight
  .sort[199].last
  .min_by { |asteroid| distance_between(*location, *asteroid) }
  .then { |x,y| x*100+y }
