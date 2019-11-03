require_relative '16/instructions.rb'

def read_instructions(filename)
  input = File.readlines(filename)

  ip_reg = input[0][/\d/].to_i

  program = input
    .drop(1)
    .map { |line|
    opcode, *rest = line.split
    instruction = INSTRUCTIONS[opcode.to_sym]
    args = rest.map(&:to_i)
    ->(regs) { instruction[*args, regs] }
  }

  return ip_reg, program
end

def step(program, regs, ip_reg)
  ip = regs[ip_reg]
  program[ip].call(regs)
  regs[ip_reg] += 1
end

def solve(program, regs, ip_reg)
  while regs[ip_reg].between?(0, program.size-1)
    step(program, regs, ip_reg)
  end

  regs[0]
end

if __FILE__ == $PROGRAM_NAME
  ip_reg, program = read_instructions('../input/input19.txt')
  p solve(program, [0,0,0,0,0,0], ip_reg)
end
