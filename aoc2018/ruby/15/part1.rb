require_relative 'io'
require_relative 'logic'

filename = ARGV[0] || '../../input/input15.txt'
units, walls, width, height = read_input(filename)

rounds = 0
game_over = false

print "\e[2J" # clear screen

loop do
  hp = units.sum { |unit| [0, unit.hp].max }
  result = rounds * hp

  print "\e[1;0H" # Move cursor to top left corner
  print "Round #{rounds} * "
  print "HP #{hp} "
  print "= #{result}\n"

  print_state(width, height, units, walls)
  break if game_over

  game_over = move_all_units(units, walls) == :game_over
  rounds += 1 unless game_over
end
