strings = File.open('input/08.txt').each_line.map { |line| line.chomp }

p strings.map { |line|
  raw = line.size
  evaluated = eval(line).size
  raw - evaluated
}.reduce(:+)
