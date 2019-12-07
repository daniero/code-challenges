require_relative 'intcode'

def run(program, diagnostic_code)
  input = [diagnostic_code]

  IntcodeComputer
    .new(program, input: input)
    .run
    .output.first
end

if __FILE__ == $0
  program = read_intcode('../input/input05.txt')

  print "Part 2: "
  puts run(program, 5)
end

