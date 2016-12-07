class String
  def abba?
    self =~ /(.)(.)\2\1/ && $1 != $2
  end

  def tls?
    split = self.split(/\[|\]|\n/)
    outside_brackets, inside_brackets = split.partition.with_index { |_, i| i.even? }

    outside_brackets.any?(&:abba?) && inside_brackets.none?(&:abba?)
  end
end


puts File.open('07_input.txt').each_line.count(&:tls?)
