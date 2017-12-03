INPUT = 265149

# Part 1

def spiral(n)

  k = ((Math.sqrt(n)-1)/2).ceil
  t= 2*k + 1
  m = t**2
  t = t-1

  return [k-(m-n), -k] if n >= m-t
  m-= t
  return [-k, -k+(m-n)] if n >= m-t
  m-= t
  return [-k+(m-n), k] if n >= m-t
  [k, k-(m-n-t)]
end

a,b = spiral(INPUT)

puts a.abs + b.abs
