Node = Struct.new(:size, :used, :avail, :use)

input = File.open('input/22.txt').each_line.drop(2)

nodes = input.reduce({}) { |hash, line|
  line =~ /x(\d+)-y(\d+).*?(\d+)T.*?(\d+)T.*?(\d+)T.*?(\d+)%/
  _, x, y, size, used, avail, use = [*$~].map(&:to_i)
  hash.merge({ [x,y] => Node.new(size, used, avail, use) })
}

p nodes.values
  .repeated_permutation(2)
  .select { |a, b| a.used != 0 }
  .select { |a,b| a != b }
  .count { |(a, b)| a.used <= b.avail }
