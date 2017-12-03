password = "hxbxwxba"

class String
  def password_ok?
    return false if self =~ /[iol]/
    return false unless chars.each_cons(3).any? { |a,b,c| a.ord == b.ord-1 && b.ord == c.ord-1 }
    return false unless self =~ /(.)\1.*(.)\2/
    true
  end

  def next_password
    s = dup.next
    s.next! until s.password_ok?
    s
  end
end

# p "hijklmmn".password_ok?
# p "abbceffg".password_ok?
# p "abbcegjk".password_ok?
# puts
# p "abcdefgh".next_password # abcdffaa
# p "ghijklmn".next_password # ghjaabcc

part1 = password.next_password
part2 = part1.next_password

puts part1, part2
