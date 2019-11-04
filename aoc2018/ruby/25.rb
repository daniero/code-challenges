def distance(p1, p2)
  p1.zip(p2).sum { |a,b| (a-b).abs }
end

constilations  = File
  .readlines('../input/input25.txt')
  .map { |line| line.scan(/-?\d+/).map(&:to_i) } 
  .map { |point| [ point ] }

loop do
  overlap = constilations.combination(2).find { |c1, c2|
    c1.product(c2).any? { |p1,p2| distance(p1, p2) <= 3 }
  }

  break unless overlap

  new_constilation = overlap.inject :+
  overlap.each &:clear
  constilations.reject! &:empty?
  constilations << new_constilation
end

p constilations.size
