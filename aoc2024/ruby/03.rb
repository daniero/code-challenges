input = File.read('../input/03-sample.txt')

p input.scan(/mul\((\d+),(\d+)\)/).sum { |a,b| a.to_i * b.to_i }
