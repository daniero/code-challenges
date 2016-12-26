p File.read('input/01.txt').chomp.each_char.reduce(0) { |sum, char| sum + (char == '(' ? 1 : -1) }
