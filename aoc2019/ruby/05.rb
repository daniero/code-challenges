require_relative 'intcode'

program = File.read('../input/input05.txt').scan(/-?\d+/).map(&:to_i)

input = StringIO.new('1')
output = StringIO.new()

IntcodeComputer.new(
  program,
  input: input,
  output: output,
).run

puts output.string
