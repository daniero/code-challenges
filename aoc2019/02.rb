input = File.read('input/input02.txt').scan(/\d+/).map(&:to_i)

def run(program, noun, verb)
  memory = program.dup

  memory[1] = noun
  memory[2] = verb

  memory.each_slice(4) { |opcode, n1, n2, target|
    case opcode
    when 1
      memory[target] = memory[n1] + memory[n2]
    when 2
      memory[target] = memory[n1] * memory[n2]
    when 99
      break
    end
  }

  return memory[0]
end


# Part 1

p run(input, 12, 2)


# Part 2

output = 19690720

possible_inputs = [*0..99]
combinations = possible_inputs.repeated_permutation(2)

p combinations
  .find { |noun, verb| run(input, noun, verb) == output }
  .then  { |noun, verb| 100 * noun + verb }

