require_relative 'intcode'

Directions = [
  [0, -1], # Up
  [1, 0],  # Right
  [0, 1],  # Down
  [-1, 0]  # Left
]

class Robot
  attr_accessor :panels, :facing, :position

  def initialize
    @facing = 0
    @position = [0, 0]
    @panels = Hash.new { 0 }
  end

  def check_color
    panels[position]
  end

  def paint(color)
    panels[position] = color
  end

  def turn(direction)
    x, y = position
    @facing += [-1, 1][direction]
    move_x, move_y = Directions[facing%4]
    @position = [x+move_x, y+move_y]
  end

end


def run(start_color = 0)
  camera_channel = Queue.new
  command_channel = Queue.new

  robot_thread = Thread.new do
    robot = Robot.new
    robot.panels[robot.position] = start_color

    loop do
      camera_channel.push(robot.check_color)

      robot.paint(command_channel.pop)
      robot.turn(command_channel.pop)
    end

    robot
  end

  Thread.new do
    intcode = read_intcode('../input/input11.txt')

    computer = IntcodeComputer
      .new(intcode, input: camera_channel, output: command_channel)
      .run

    camera_channel.close
  end

  robot_thread.value.panels
end


# Part 1
p run(0).size
puts


# Part 2
panels = run(1)

min_x, max_x, min_y, max_y = panels.keys.transpose.flat_map(&:minmax)

(min_y..max_y).each { |y|
  puts (min_x..max_x).map { |x| panels[[x,y]] == 1 ? '#' : ' ' }.join
}
