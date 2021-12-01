input = File.readlines('../input/01.txt').map(&:to_i)

# Part 1
p input.each_cons(2).count { _1 < _2 }

# Part 2
p input.each_cons(3).map(&:sum).each_cons(2).count { _1 < _2 }
