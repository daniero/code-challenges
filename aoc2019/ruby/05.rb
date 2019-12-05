require_relative 'intcode'

def run(program, diagnostic_code)
  input = StringIO.new(diagnostic_code.to_s)
  output = StringIO.new()

  IntcodeComputer.new(
    program,
    input: input,
    output: output,
  ).run

  return output.string.to_i
end

if __FILE__ == $0
  program = read_intcode('../input/input05.txt')

  print "Part 2: "
  puts run(program, 5)
end

