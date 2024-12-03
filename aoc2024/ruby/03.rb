input = File.read('../input/03-sample.txt')

# Part 1
p input
  .scan(/mul\((\d+),(\d+)\)/).sum { |a,b| a.to_i * b.to_i }


# Part 2
p input
  .gsub(/don't\(\).*?do\(\)/m,'---skip---')
  .scan(/mul\((\d+),(\d+)\)/).sum { |a,b| a.to_i * b.to_i }
