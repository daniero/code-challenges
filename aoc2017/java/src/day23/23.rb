PART = 2

def label(i, statements, goto_next=true)
  "case #{i}: #{statements}; #{'go++;' if goto_next}"
end

input = File.readlines('../input23.txt')

if PART == 1
  puts (?a..?h).map { |c| "long #{c} = 0;" }

  puts input.each_with_index.map { |line, i|
    line
      .gsub(/set (.) (-?\w+)/) { label(i, "#$1 = #$2") }
      .gsub(/sub (.) (-?\w+)/) { label(i, "#$1-= #$2") }
      .gsub(/mul (.) (-?\w+)/) { label(i, "mul++; #$1*= #$2") }
      .gsub(/jnz 1 (-?\w+)/) {  label(i, "go = #{i + $1.to_i}; break", false) }
      .gsub(/jnz (.) (-?\w+)/) { label(i, "if (#$1 != 0) { go = #{i + $2.to_i}; break; }") }
  }
elsif PART == 2
  puts (?b..?h).map { |c| "long #{c} = 0;" }

  puts input.each_with_index.map { |line, i|
    line
      .gsub(/set (.) (-?\w+)/) { label(i, "#$1 = #$2") }
      .gsub(/sub (.) (-?\w+)/) { label(i, "#$1-= #$2") }
      .gsub(/mul (.) (-?\w+)/) { label(i, "#$1*= #$2") }
      .gsub(/jnz [a1] (-?\w+)/) {  label(i, "go = #{i + $1.to_i}; break", false) }
      .gsub(/jnz (.) (-?\w+)/) { label(i, "if (#$1 != 0) { go = #{i + $2.to_i}; break; }") }
  }
end
