def overlap?(range1, range2)
  min, max = [range1, range2].minmax_by(&:first)
  min.cover?(max.first) || min.last + 1 == max.first
end

def merge_overlapping_ranges(*ranges)
  starts, stops = ranges.map { |range| [range.first, range.last] }.transpose
  Range.new(starts.min, stops.max)
end

def merge_ranges(ranges)
  ranges.reduce([]) do |processed, current|
    overlapping, distinct = processed.partition { |range| overlap?(range, current) }
    merged = merge_overlapping_ranges(current, *overlapping)
    [merged, *distinct]
  end
end

filename = ARGV[0] || 'input/20.txt'
input = File.open(filename).each_line.map { |line| Range.new(*line.split('-').map(&:to_i)) }

blacklist = merge_ranges(input)

# Part 1
p blacklist.min_by(&:first).last + 1

# Part 2
p 2**32 - blacklist.reduce(0) { |count, range| count + range.size }
