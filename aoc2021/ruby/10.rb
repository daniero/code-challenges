input = File.readlines(ARGV[0] || '../input/10.txt').map(&:chomp)

unchunked = input.map do |line|
  a = line.dup

  loop {
    b = a.dup
    a.gsub! '()', ''
    a.gsub! '[]', ''
    a.gsub! '{}', ''
    a.gsub! '<>', ''
    break if a.empty? || a == b
  }

  a
end

puts unchunked.sum { |line|
  case line[/[)\]}>]/]
  when ')'; 3
  when ']'; 57
  when '}'; 1197
  when '>'; 25137
  else; 0
  end
}

