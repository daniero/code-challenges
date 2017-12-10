input = File.read('../input09.txt')

# Part 2
p input.gsub(/!./,'').scan(/(?<=<)[^>]*/).join.size
