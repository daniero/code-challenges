def distance(a,b,c)
  Math.sqrt(a**2 + b**2 + c**2)
end

p File.readlines('../input20.txt')
  .map { |line| line.scan(/-?\d+/).map(&:to_i).each_slice(3).to_a }
  .each_with_index
  .min_by { |((a,b,c),(d,e,f),(g,h,i)),_| [distance(g,h,i), distance(d,e,f), distance(a,b,c)] }
  .last
