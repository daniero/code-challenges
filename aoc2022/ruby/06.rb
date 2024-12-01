input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

def solve(s, n)
  s.chars.each_cons(n).find_index { |a| a.uniq.size == n } + n
end

p solve(input, 4)
p solve(input, 14)
