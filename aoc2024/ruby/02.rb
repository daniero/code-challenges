input = File
  .readlines('../input/02-sample.txt')
  .map { |line| line.scan(/\d+/).map &:to_i }


def normalize(a)
  a == a.sort ? a : a.reverse
end

def is_safe(a)
  a.each_cons(2).all? { |a,b| d = b - a; d >= 1 && d <= 3 }
end

def ok(a)
  is_safe(normalize(a))
end


# Part 1

p input.count { |a| ok(a) }


# Part 2

def dampen(a)
  (0...a.length).map { |i| a[0...i] + a[(i+1)...a.length] }
end

p input.count { |a| ok(a) || dampen(a).any? { ok(_1) } }


