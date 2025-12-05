a,b = File
  .read('../input-real05.txt')
  .split("\n\n")

ranges = a.lines.map { it.scan(/\d+/).map(&:to_i).then { Range.new *it } }
ids = b.lines.map(&:to_i)

p ids.count { |id| ranges.any? { |range| range.cover? id } }
