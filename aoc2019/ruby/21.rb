require_relative 'intcode'

def run_springcode(intcode, springcode)
  output = IntcodeComputer.new(
    intcode,
    input: springcode.chars.map(&:ord)
  ).run.output

  puts output.map { |int| int > 127 ? int.to_s : int.chr }.join
end


intcode = read_intcode('../input/input21.txt')

puts "== PART 1 =="
run_springcode(intcode, <<END)
NOT A J
NOT B T
OR T J
NOT C T
OR T J
AND D J
WALK
END
