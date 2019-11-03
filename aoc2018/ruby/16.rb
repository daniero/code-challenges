INSTRUCTIONS = {
  addr: ->(a,b,c, regs) { regs[c] = regs[a] + regs[b] },
  addi: ->(a,b,c, regs) { regs[c] = regs[a] + b },
  mulr: ->(a,b,c, regs) { regs[c] = regs[a] * regs[b] },
  muli: ->(a,b,c, regs) { regs[c] = regs[a] * b },
  banr: ->(a,b,c, regs) { regs[c] = regs[a] & regs[b] },
  bani: ->(a,b,c, regs) { regs[c] = regs[a] & b },
  borr: ->(a,b,c, regs) { regs[c] = regs[a] | regs[b] },
  bori: ->(a,b,c, regs) { regs[c] = regs[a] | b },
  setr: ->(a,_,c, regs) { regs[c] = regs[a] },
  seti: ->(a,_,c, regs) { regs[c] = a },
  gtir: ->(a,b,c, regs) { regs[c] = a > regs[b] ? 1 : 0 },
  gtri: ->(a,b,c, regs) { regs[c] = regs[a] > b ? 1 : 0 },
  gtrr: ->(a,b,c, regs) { regs[c] = regs[a] > regs[b] ? 1 : 0 },
  eqir: ->(a,b,c, regs) { regs[c] = a == regs[b] ? 1 : 0 },
  eqri: ->(a,b,c, regs) { regs[c] = regs[a] == b ? 1 : 0 },
  eqrr: ->(a,b,c, regs) { regs[c] = regs[a] == regs[b] ? 1 : 0 },
}

def test_run(instruction, parameters, input)
  output = input.dup
  instruction[*parameters, output]
  output
end


# Input

section1, section2 = File.read('../input/input16.txt').split(/\n{4}/m)

samples = section1
  .split(/\n\n/m)
  .map(&:lines)
  .map { |lines| lines.map { |line| line.scan(/\d+/).map(&:to_i) }  }


# Part 1

part1 = samples.count { |before, opcode, after|
  _, *parameters = opcode

  matches = INSTRUCTIONS.values.count { |instruction|
    test_run(instruction, parameters, before) == after
  }

  matches >= 3
}

puts part1


# Part 2

require 'set'
possible_opcodes = Array.new(INSTRUCTIONS.size) { Set.new(INSTRUCTIONS.keys) }

samples.each { |before, opcode, after|
  n, *parameters = opcode

  matches = INSTRUCTIONS.keys.select { |name|
    instruction = INSTRUCTIONS[name]
    test_run(instruction, parameters, before) == after
  }

  possible_opcodes[n] &= matches

}

loop do
  only_one, multiple = possible_opcodes.partition { |matches| matches.size == 1 }
  break if multiple.empty?

  multiple.each { |m| only_one.each { |o| o.each { |q| m.delete q } } }
end

instructions = possible_opcodes.flat_map(&:to_a).map(&INSTRUCTIONS)
program = section2.lines.map { |line| line.scan(/\d+/).map(&:to_i) }


regs = [0,0,0,0]

program.each do |opcode, *args|
  instructions[opcode][*args, regs]
end

p regs[0]
