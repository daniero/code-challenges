def distance(p1, p2)
  p1.zip(p2).sum { |a,b| (a-b).abs }
end

constilations  = File
  .readlines('../input/input25.txt')
  .map { |line| line.scan(/-?\d+/).map(&:to_i) } 
  .map { |point| [ point ] }

loop do
  overlaps = constilations.combination(2).select { |c1, c2|
    if c1.product(c2).any? { |p1,p2| distance(p1, p2) <= 3 }
      c1.concat(c2)
      c2.clear
    end
  }

  break if overlaps.empty?

  constilations.reject! &:empty?
end

p constilations.size
