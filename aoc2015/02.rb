p File.open('input/02.txt')
  .each_line.map { |line| line.split('x').map(&:to_i) }
  .map { |l,w,h| a,b,c = *l*w,  *w*h,  *h*l; 2*a + 2*b + 2*c + [a,b,c].min }
  .reduce(:+)
