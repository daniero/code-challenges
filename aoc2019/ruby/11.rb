require_relative 'intcode'

Directions = [
  [0, -1], # Up
  [1, 0],  # Right
  [0, 1],  # Down
  [-1, 0]  # Left
]

class Robot
  attr_accessor :panel_colors, :facing, :position

  def initialize
    @facing = 0
    @position = [0, 0]
    @panel_colors = Hash.new { 0 }
  end

  def check_color
    panel_colors[position]
  end

  def paint(color)
    panel_colors[position] = color
  end

  def turn(direction)
    x, y = position
    @facing += [-1, 1][direction]
    move_x, move_y = Directions[facing%4]
    @position = [x+move_x, y+move_y]
  end

  alias shift check_color
  alias push paint
end


camera_channel = Queue.new
command_channel = Queue.new


robot_thread = Thread.new do
  robot = Robot.new
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


p robot_thread.value.panel_colors.size
