def turn(square)
  square.transpose.map { |line| line.reverse }
end

def find_flips_and_rotations(square)
  4.times
    .flat_map { |i|
      rotated = square
      i.times { rotated = turn(rotated) }

      flipped_h = rotated.map(&:reverse)
      flipped_v = rotated.reverse

      [rotated, flipped_h, flipped_v]
    }
    .uniq
end

def subsquare(canvas, x, y, size)
  size.times.map { |i| size.times.map { |j| canvas[i + x*size][j + y*size] } }
end

def set_subsquare(canvas, square, x, y, size)
  new_canvas = canvas.dup
  size.times { |i|
    size.times { |j|
      new_canvas[i + x*size][j + y*size] = square[i][j]
    }
  }
  new_canvas
end


init = <<END.lines.map(&:chomp).map(&:chars)
.#.
..#
###
END

rules = File
  .open('../input/input21.txt')
  .each_line
  .flat_map { |line|
    from, to = line.scan(/[.#\/]+/).map { |r| r.split('/').map(&:chars) }
    flips_and_rotations = find_flips_and_rotations(from)
    flips_and_rotations.map { |from_flipped| [from_flipped, to] }
  }
  .to_h

art = init

5.times do
  if art.size % 2 == 0
    squares = art.size / 2
    new_size = art.size / 2 * 3 
  elsif art.size % 3 == 0
    squares = art.size / 3
    new_size = art.size / 3 * 4
  else
    raise "weird size: "+ art.size
  end

  new_art = Array.new(new_size) { Array.new(new_size) }

  squares.times do |x|
    squares.times do |y|
      square = subsquare(art, x, y, art.size / squares)

      new_square = rules[square]
      set_subsquare(new_art, new_square, x, y, new_size/squares)
    end
  end

  art = new_art
end

puts art.flatten.count('#')
