require_relative '16/instructions.rb'

regs = [0] * 6

input = File.readlines('../input/input19.txt')
ip_reg = input[0][/\d/].to_i

program = input
  .drop(1)
  .map { |line|
    opcode, *rest = line.split
    args = rest.map(&:to_i)
    instruction = INSTRUCTIONS[opcode.to_sym]
    ->() { instruction[*args, regs] }
  }

while regs[ip_reg].between?(0, program.size-1)
  ip = regs[ip_reg]
  #p [ip, regs]
  program[ip].call()

  regs[ip_reg] += 1

end

p regs[0]
