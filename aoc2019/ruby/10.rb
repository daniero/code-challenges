asteroids = File
  .open('../input/input10.txt')
  .each_line
  .with_index
  .flat_map { |line, linenum|
    line
      .each_char
      .with_index
      .flat_map { |char, charnum|
        char == '#' ?  [[linenum, charnum]] : []
      }
  }

def radians_between(x1, y1, x2, y2)
  Math.atan2(x2-x1, y2-y1)
end

pp asteroids.map { |asteroid|
  others = asteroids - asteroid
  in_line = others.group_by { |other| radians_between(*asteroid, *other) }
  in_line.size
}.max
