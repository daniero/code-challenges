require 'digest'
md5 = Digest::MD5

input = "wtnhxymk"
length = 8

pass1 = []
pass2 = []

part1_solved = false
part2_solved = false

i = foo = 0

until part2_solved
  hash = md5.hexdigest "#{input}#{i}"

  if hash.start_with? '00000'
    a, b = hash.chars[5..6]

    unless part1_solved
      pass1 << a
      foo += 1
      part1_solved = (foo == length)
    end

    if a >= '0' && a <= '7'
      pass2[a.to_i] ||= b
      part2_solved = (pass2.compact.size == length)
    end

  end

  i+= 1
end

puts pass1.join
puts pass2.join
