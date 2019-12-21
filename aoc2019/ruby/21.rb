require_relative 'intcode'

def run_springcode(intcode, springcode)
  output = IntcodeComputer.new(
    intcode,
    input: springcode.chars.map(&:ord)
  ).run.output

  output.map { |int| int > 127 ? int.to_s : int.chr }.join
end


intcode = read_intcode('../input/input21.txt')

puts "== PART 1 =="
puts run_springcode(intcode, <<END)
OR A J
AND B J
AND C J
NOT J J
AND D J
WALK
END
