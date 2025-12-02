ids = File
  .read('../input-sample02.txt')
 #.read('../input-real02.txt')
  .scan(/\d+/).map(&:to_i).each_slice(2)


print "Part 1: "

p ids.sum { |a,b|
  (a..b).filter { |n| n.to_s =~ /^(.+)\1$/ }.sum
}
