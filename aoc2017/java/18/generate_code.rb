input = File.read('../../input18.txt')

registers = input.scan(/(?<=^... )[a-z]/).uniq
puts (registers - ['p']).map { |r| "long #{r} = 0;" }
puts

def label(i, statements)
  "case #{i}: #{statements}; GOTO++;"
end

puts input.lines.each_with_index.map { |line, i|
  line
    .gsub(/snd (.)/) { label(i, "snd(#$1)") }
    .gsub(/rcv (.)/) { label(i, "#$1 = rcv()") }
    .gsub(/set (.) (-?\w+)/) { label(i, "#$1 = #$2") }
    .gsub(/add (.) (-?\w+)/) { label(i, "#$1+= #$2") }
    .gsub(/mul (.) (-?\w+)/) { label(i, "#$1*= #$2") }
    .gsub(/mod (.) (-?\w+)/) { label(i, "#$1%= #$2") }
    .gsub(/jgz (.) (-?\w+)/) { label(i, "if (#$1 > 0) { GOTO+= #$2; break; }") }
}

