input = File.readlines('../input/07.txt')

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


# Part 1
p sizes.values.filter { |v| v < 100_000 }.sum

# Part 2
total_space = 70_000_000
required_space = 30_000_000
used_space = sizes["/"]
free_space = total_space - used_space
need_to_free = required_space - free_space

p sizes
  .values
  .filter { _1 >= need_to_free }
  .min


