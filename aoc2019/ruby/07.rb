require_relative 'intcode'

def run_single(program, sequence)
  first_input = 0

  sequence.reduce(first_input) { |input, phase_setting|
    amp = IntcodeComputer.new(program, input: [phase_setting, input])
    amp.run.output.first
  }
end

def find_max_signal(program, input_range)
  [*input_range]
    .permutation
    .map { |sequence| yield(program, sequence) }
    .max
end

program = read_intcode('../input/input07.txt')


# Part 1

p find_max_signal(program, 0..4, &method(:run_single))


# Part 2

def run_with_feedback(program, sequence)
  channels = sequence.map { |phase_setting| Queue.new.push(phase_setting) }

  threads = sequence.map.with_index { |_,i|
    Thread.new do
      amp = IntcodeComputer.new(
        program,
        input: channels[i],
        output: channels[(i+1)%channels.length]
      )
      amp.run
    end
  }

  channels.first.push(0)
  threads.each(&:join)
  channels.first.pop
end

p find_max_signal(program, 5..9, &method(:run_with_feedback))
