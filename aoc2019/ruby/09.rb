require_relative 'intcode'

program = read_intcode('../input/input09.txt')

puts IntcodeComputer
  .new(program, input: [1])
  .run
  .output

puts IntcodeComputer
  .new(program, input: [2])
  .run
  .output
