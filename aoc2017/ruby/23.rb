def label(i, statements, goto_next=true)
  "case #{i}: #{statements}; #{'go++;' if goto_next}"
end

puts (?a..?h).map { |c| "long #{c} = 0;" }

puts <<BOILERPLATE

int go = 0;
int mul = 0;

while(true)
switch (go) {
BOILERPLATE

input = File.readlines('../input23.txt')

puts input.each_with_index.map { |line, i|
  line
    .gsub(/set (.) (-?\w+)/) { label(i, "#$1 = #$2") }
    .gsub(/sub (.) (-?\w+)/) { label(i, "#$1-= #$2") }
    .gsub(/mul (.) (-?\w+)/) { label(i, "mul++; #$1*= #$2") }
    .gsub(/jnz 1 (-?\w+)/) {  label(i, "go+= #$1; break", false) }
    .gsub(/jnz (.) (-?\w+)/) { label(i, "if (#$1 != 0) { go+= #$2; break; }") }
}

puts "}"
