input = File.open('06_input.txt').each_line.map { |line| line.chop.chars }

cols = input.transpose.map { |col| col.sort_by { |char| col.count(char) } }

# Part 1
p cols.transpose.last.join

# Part 2
p cols.transpose.first.join
