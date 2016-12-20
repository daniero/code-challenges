def overlap?(start1, stop1, start2, stop2)
  start1 <= start2 && stop1 >= start2 - 1 ||
    start2 <= start1 && stop2 >= start1 - 1
end

def merge_overlapping_ranges(ranges)
  all_to, all_from = ranges.transpose
  [all_to.min, all_from.max]
end

def merge_ranges(ranges)
  ranges.reduce([]) do |previous, (current_start, current_stop)|
    overlapping, distinct = previous.partition { |to, from| overlap?(to,from, current_start,current_stop) }

    distinct + [merge_overlapping_ranges(overlapping << [current_start, current_stop])]
  end
end

filename = ARGV[0] || 'input/20.txt'
input = File.open(filename).each_line.map { |line| line.split('-').map(&:to_i) }

blacklist = merge_ranges(input)
p blacklist.min.last + 1
