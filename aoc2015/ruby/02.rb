presents = File.open('../input/02.txt') .each_line.map { |line| line.split('x').map(&:to_i) }

# Part 1
p presents
  .map { |l,w,h| a,b,c = *l*w,  *w*h,  *h*l; 2*a + 2*b + 2*c + [a,b,c].min }
  .reduce(:+)

# Part 2
p presents
  .map { |l,w,h| [l,w,h].combination(2).map { |a,b| a+a+b+b }.min + l*w*h }
  .reduce(:+)
