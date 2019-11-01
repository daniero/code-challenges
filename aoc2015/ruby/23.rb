instructions =
  File
  .readlines('../input/23.txt')
  .map { |line|
    line
      .sub(/hlf (.)/) { "(#$1 /= 2; 1)" }
      .sub(/tpl (.)/) { "(#$1 *= 3; 1)" }
      .sub(/inc (.)/) { "(#$1 += 1; 1)" }
      .sub(/jmp ([+-]\d+)/) { $1 }
      .sub(/jie (.), ([+-]\d+)/) { "#$1 %2 == 0 ? #$2 : 1" }
      .sub(/jio (.), ([+-]\d+)/) { "#$1 == 1 ? #$2 : 1" }
  }

# Part 1

a = 0
b = 0
ip = 0

while ip >= 0 && ip < instructions.length
  ip += eval(instructions[ip])
end

puts b

# Part 2

a = 1
b = 0
ip = 0

while ip >= 0 && ip < instructions.length
  ip += eval(instructions[ip])
end

puts b
