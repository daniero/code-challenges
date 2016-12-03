U,R,D,L = "URDL".chars

keypad1 = {
  1 => {R => 2, D => 4},
  2 => {R => 3, D => 5, L => 1},
  3 => {D => 6, L => 2},
  4 => {U => 1, R => 5, D => 7},
  5 => {U => 2, R => 6, D => 8, L => 4},
  6 => {U => 3, D => 9, L => 5},
  7 => {U => 4, R => 8},
  8 => {U => 5, R => 9, L => 7},
  9 => {U => 6, L => 8},
}

A,B,C = "ABC".chars

keypad2 = {
  1 => {D => 3},
  2 => {R => 3, D => 6},
  3 => {U => 1, R => 4, D => 7, L => 2},
  4 => {D => 8, L => 3},
  5 => {R => 6},
  6 => {U => 2, R => 7, D => A, L => 5},
  7 => {U => 3, R => 8, D => B, L => 6},
  8 => {U => 4, R => 9, D => C, L => 7},
  9 => {L => 8},
  A => {U => 6, R => B},
  B => {U => 7, R => C, D => D, L => A},
  C => {U => 8, L => B},
  D => {U => B}
}

lines = File.read('02_input.txt').lines.map(&:strip)

keypad = keypad2	# solve part 1 or part 2
key = 5

combo = lines.map do |line|
  line.each_char { |move| key = keypad[key][move] || key }
  key
end

puts combo.join
