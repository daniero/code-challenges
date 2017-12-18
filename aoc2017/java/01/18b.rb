require 'set'

input = File.read('../input18.txt')

registers = input.scan(/(?<=^... )./).uniq
puts registers.map { |r| "int #{r} = 0;" }  # TODO register `p` must be 1 for one of the programs

puts input
  .gsub(/snd (.)/) { "snd(#$1);" }
  .gsub(/rcv (.)/) { "#$1 = rcv();" }
  .gsub(/set (.) (-?\w+)/) { "#$1 = #$2;" }
  .gsub(/add (.) (-?\w+)/) { "#$1+= #$2;" }
  .gsub(/mul (.) (-?\w+)/) { "#$1*= #$2;" }
  .gsub(/mod (.) (-?\w+)/) { "#$1%= #$2;" }

p registers
