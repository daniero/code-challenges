strings = File.open('input/08.txt').each_line.map { |line| line.chomp }

def solve(strings)
  strings.map { |string|
    raw = string.size
    evaluated = yield(string).size
    raw - evaluated
  }.reduce(:+)
end

p solve(strings) { |s| eval(s) }
p -solve(strings) { |s| s.inspect }
