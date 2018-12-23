def distance(pos1,pos2)
  pos1.zip(pos2).sum { |a,b| (a-b).abs }
end

nanobots = File
  .open('../input/input23.txt')
  .each_line
  .map { |line| line.scan(/-?\d+/).map(&:to_i) }

x,y,z,max_range = nanobots.max_by(&:last)

p nanobots.count { |a,b,c,_| distance([x,y,z],[a,b,c]) <= max_range }
