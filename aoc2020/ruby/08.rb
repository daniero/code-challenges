require 'set'

instructions = File
  .readlines('../input/08.txt')
  .map { |line|
    line =~ /(\w+) ([+-]\d+)/
    [$1, $2.to_i]
}

def run_until_loop_or_terminate(instructions)
  ip = 0;
  acc = 0;

  visited = Set[]

  loop do
    return [false, acc] unless visited.add?(ip)
    return [true, acc] if 0 > ip || ip >= instructions.size

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
      raise "Unknow instruction @ #{ip}: '#{inst} #{arg}'"
    end

  end
end


# Part 1

_, result = run_until_loop_or_terminate(instructions)
puts result


# Part 2

instructions.each_with_index do |(inst, arg), index|
  next unless inst == 'jmp' || inst == 'nop'

  new_instructions = instructions.dup
  new_instructions[index] = ['jmpnop'.sub(inst,''), arg]

  terminated, result = run_until_loop_or_terminate(new_instructions)

  if terminated
    puts result
    break
  end
end
