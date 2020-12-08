require 'set'

instructions = File
  .readlines('../input/08.txt')
  .map { |line|
    line =~ /(\w+) ([+-]\d+)/
    [$1, $2.to_i]
  }

ip = 0;
acc = 0;

visited = Set.new

while ip >= 0 && ip < instructions.length
  break unless visited.add?(ip)

  inst, arg = instructions[ip]
  case inst
  when 'acc'
    acc += arg
    ip += 1
  when 'jmp'
    ip += arg
  when 'nop'
    ip += 1
  else
    raise "Unknow instruction @ ${ip}: '${inst} ${arg}'"
  end

end

puts acc
