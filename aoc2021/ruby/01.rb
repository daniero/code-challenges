input = File.readlines('../input/01.txt').map(&:to_i)

p input.each_cons(2).count { _1 < _2 }
