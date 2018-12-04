require 'set'

claims =
  File.readlines('../input/input03.txt')
  .map { |line|
    line
      .scan(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
      .first
      .map(&:to_i)
  }

N = 1001
fabric = Array.new(N) { Array.new(N) }
non_overlapping = Set[*claims.map { |id, *_| id }]
overlaps = 0

claims.each do |id, x, y, l, h|
  (x...x+l).each do |i|
    (y...y+h).each do |j|
      if fabric[i][j].nil?
        fabric[i][j] = id
      else
        overlaps+=1
        non_overlapping.delete fabric[i][j]
        non_overlapping.delete id
      end
    end
  end
end

p overlaps
p *non_overlapping
