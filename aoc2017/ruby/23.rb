def label(i, statements)
  "case #{i}: #{statements}; go++;"
end

puts (?a..?h).map { |c| "long #{c} = 0;" }

input = File.readlines('../input23.txt')

puts input.each_with_index.map { |line, i|
  java =
    line
    .gsub(/set (.) (-?\w+)/) { "#$1 = #$2" }
    .gsub(/sub (.) (-?\w+)/) { "#$1-= #$2" }
    .gsub(/mul (.) (-?\w+)/) { "mul++; #$1*= #$2" }
    .gsub(/jnz (.) (-?\w+)/) { "if (#$1 != 0) { go+= #$2; break; }" }
  label(i, java.chomp)
}

