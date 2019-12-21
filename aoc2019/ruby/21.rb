require_relative 'intcode'

program = read_intcode('../input/input21.txt')

puts IntcodeComputer.new(
  program,
  input: DATA.read.chars.map(&:ord)
).run.output.map(&:chr).join


__END__
NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
WALK

