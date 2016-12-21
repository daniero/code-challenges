PASSWORD = "abcdefgh"
INPUT = File.read(ARGV[0] || 'input/21.txt').lines

def scramble(password)
  INPUT.each do |line|
    case line
    when /swap position (\d+) with position (\d+)/
      a, b = $1.to_i, $2.to_i 
      password[a], password[b] = password[b], password[a]
      password

    when /swap letter (.) with letter (.)/
      a,b = $1, $2
      password.gsub! a, '_'
      password.gsub! b, a
      password.gsub! '_', b
      password

    when /rotate (left|right) (\d+) steps?/
      direction = $1 == 'left' ? 1 : -1
      steps = $2.to_i
      password = password.chars.rotate(steps * direction).join

    when /rotate based on position of letter (.)/
      letter = $1
      index = password.index(letter)
      password = password.chars.rotate(-index - 1 - (index >= 4 ? 1 : 0 )).join

    when /reverse positions (\d+) through (\d+)/
      a, b = $1.to_i, $2.to_i
      password[a..b] = password[a..b].reverse

    when /move position (\d+) to position (\d+)/
      a, b = $1.to_i, $2.to_i
      c = password[a]
      password[a] = ''
      password = password[0...b] + c + password[b..-1]
    end
  end
  password
end

# Part 1
puts scramble(PASSWORD)
