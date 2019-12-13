require_relative 'intcode'

program = read_intcode('../input/input13.rb')

puts IntcodeComputer
  .new(program)
  .run
  .output
  .each_slice(3)
  .map(&:last)
  .count(2)
