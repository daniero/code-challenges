def triangle(n) 
  n*(n+1)/2
end

def pentagonal(n) 
  n*(3*n-1)/2
end

def hexagonal(n)
  n*(2*n-1)
end

tn, t = 286, triangle(286)
pn, p = 165, pentagonal(165)
hn, h = 143, hexagonal(143)

loop do |n|
  if t == p && p == h
    p t
    break
  end

  if t < p || t < h
    tn, t = tn+1, triangle(tn+1)
  elsif p < t || p < h
    pn, p = pn+1, pentagonal(pn+1)
  elsif h < t || h < p
    hn, h = hn+1, hexagonal(hn+1)
  end

end
