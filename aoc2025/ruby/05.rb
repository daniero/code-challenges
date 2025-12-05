a,b = File
  .read('input-05.txt')
  .split("\n\n")

ranges = a.lines.map { Range.new *it.scan(/\d+/).map(&:to_i) }
ids = b.lines.map(&:to_i)


print "Part 1: "
puts ids.count { |id| ranges.any? { |range| range.cover? id } }


print "Part 2: "

without_overlap = ranges
  .sort_by { [it.min, -it.size] }
  .reduce([]) { |rs, r|
    next [r] if rs.empty?
    next rs if rs.last.cover? r
    next rs if r.min < rs.last.min && r.max <= rs.last.max

    start = [r.min, rs.last.max+1].max
    next_range = Range.new(start, r.max)
    next rs if rs.last.cover? next_range

    [*rs, next_range]
  }

puts without_overlap.sum { it.size }
