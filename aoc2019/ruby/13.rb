require_relative 'intcode'
require_relative 'keypress'

program = read_intcode('../input/input13.rb')


# Part 1

puts IntcodeComputer
  .new(program)
  .run
  .output
  .each_slice(3)
  .map(&:last)
  .count(2)


# Part 2

Empty = 0
Wall = 1
Block = 2
Paddle = 3
Ball = 4

def print_screen(screen)
  max_x, max_y = p screen.keys.transpose.map(&:max)

  (0..max_y).each { |y|
    puts (0..max_x).map { |x|
      case pixel = screen[[x,y]]
      when Empty
        ' '
      when Wall
        '#'
      when Block
        '.'
      when Paddle
        '='
      when Ball
        'o'
      else
        pixel
      end
    }.join
  }
end

io = Object.new
screen = Hash.new { Empty }
buffer = []

io.define_singleton_method(:push) do |value|
  x,y,id = buffer.push(value)
  if buffer.length == 3
    screen[[x,y]] = id
    buffer.clear
  end
end

io.define_singleton_method(:shift) do
  print_screen(screen)
  puts "Score: #{screen[[-1,0]]}"

  c = read_char
  raise StopIteration unless c
  c == 'a' ? -1 : c == 'd' ? 1 : 0
end


IntcodeComputer
  .new(program, input: io, output: io)
  .apply { memory[0] = 2 }
  .run
