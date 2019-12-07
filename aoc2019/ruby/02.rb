require_relative 'intcode'

def run(program, noun, verb)
  IntcodeComputer
    .new(program)
    .apply { memory[1] = noun; memory[2] = verb }
    .run
    .memory[0]
end

input = File.read('../input/input02.txt').scan(/\d+/).map(&:to_i)


# Part 1

p run(input, 12, 2)


# Part 2

output = 19690720

possible_inputs = [*0..99]
combinations = possible_inputs.repeated_permutation(2)

p combinations
  .find { |noun, verb| run(input, noun, verb) == output }
  .then  { |noun, verb| 100 * noun + verb }

