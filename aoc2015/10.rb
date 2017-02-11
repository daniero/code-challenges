input = "1321131112"

def look_and_say(s)
  s.gsub(/(.)\1*/) { $&.size.to_s + $1 }
end

part1 = 40.times.reduce(input) { |s,_| look_and_say(s) }
puts part1.size
