input = File.readlines(ARGV[0] || '../input/10.txt').map(&:chomp)

unchunked = input.map do |line|
  a = line.dup

  loop {
    b = a.dup
    a.gsub! '()', ''
    a.gsub! '[]', ''
    a.gsub! '{}', ''
    a.gsub! '<>', ''
    break if a == b
  }

  a
end

# Part 1

puts unchunked.sum { |line|
  case line[/[)\]}>]/]
  when ')'; 3
  when ']'; 57
  when '}'; 1197
  when '>'; 25137
  else; 0
  end
}

# Part 2

scores = unchunked
  .reject { |line| line[/[\)\]\}\>]/] }
  .map { |line|
    line.chars.reverse
      .reduce(0) { |score, c|
        score * 5 + case c
        when '('; 1
        when '['; 2
        when '{'; 3
        when '<'; 4
        end
      }
  }

puts scores.sort[scores.length/2]
