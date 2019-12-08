WIDTH = 25
HEIGHT = 6

pixels = File.read('../input/input08.txt').chomp.chars.map(&:to_i)
layers = pixels.each_slice(WIDTH*HEIGHT)


# Part 1

p layers
  .min_by { |layer| layer.count(0) }
  .then { |layer| layer.count(1) * layer.count(2) }


# Part 2

BLACK = 0
WHITE = 1
TRANSPARENT = 2


def stack_pixels(a, b)
  a == TRANSPARENT ? b : a
end

image = layers
  .to_a
  .transpose
  .map { |pixel| pixel.reduce(&method(:stack_pixels)) }

puts image
  .each_slice(WIDTH)
  .map { |row| row.map(&{ BLACK => ' ', WHITE => '#'}) }
  .map(&:join)
       
