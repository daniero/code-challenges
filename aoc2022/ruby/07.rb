input = File.readlines('../input/07-sample.txt')

fs = {}
wd = fs
path = []

input.each do |line|
  case line.chomp
  when '$ cd ..'
    path.pop
    wd = path.reduce(fs) { |d,s| d[s] ||= {} }
  when /\$ cd (.+)/
    path.push $1
    wd = path.reduce(fs) { |d,s| d[s] ||= {} }
  when '$ ls'
    nil
  when /dir (\w+)/
    wd[$1] = {}
  when /(\d+) (.+)/
    wd[$2] = $1.to_i
  end
end

pp fs


def part1(fs, path=[], sizes={})
  total = fs.sum do |k, v|
    s = if v.is_a? Numeric
      v
    else
      part1(v, path + [k], sizes)
    end
  end

  sizes[path.join("/")] = total

  total
end

sizes = {}
part1(fs, [], sizes)

pp sizes
pp sizes.values.filter { |v| v < 100_000 }.sum
