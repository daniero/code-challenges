require_relative 'intcode'

def run(program, sequence)
  first_input = 0

  sequence.reduce(first_input) { |input, phase_setting|
    amp = IntcodeComputer.new(program, input: [phase_setting, input])
    amp.run.output.first
  }
end

def find_max_signal(program)
  [*0...5]
    .permutation
    .map { |sequence| run(program, sequence) }
    .max
end

program = read_intcode('../input/input07.txt')

p find_max_signal(program)
