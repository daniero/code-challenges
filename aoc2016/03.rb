input = File.readlines('03_input.txt').map { |line| line.split.map(&:to_i) }

p input.count { |tuple| a,b,c = tuple.sort; a + b > c }
