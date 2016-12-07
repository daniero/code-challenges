class String
  def abba?
    self =~ /(.)(.)\2\1/ && $1 != $2
  end

  def bracket_split
    split = self.split(/\[|\]|\n/)
    split.partition.with_index { |_, i| i.even? }
  end

  def tls?
    outside_brackets, inside_brackets = bracket_split

    outside_brackets.any?(&:abba?) && inside_brackets.none?(&:abba?)
  end

  def ssl?
    outside_brackets, inside_brackets = bracket_split

    outside_brackets.any? { |string|
      string.chars.each_cons(3).any? { |a,b,c|
        a == c && a != b && inside_brackets.grep(/#{b}#{a}#{b}/).any?
      }
    }
  end
end

# Part 1
puts File.open('07_input.txt').each_line.count(&:tls?)

# Part 2
puts File.open('07_input.txt').each_line.count(&:ssl?)
