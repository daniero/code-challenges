def distance(n, ne, se)
  [n, ne, se].map(&:abs).sort.reverse.take(2).reduce(:+)
end

def path_length(path)
  dirs = Hash.new { 0 }
  path.each { |dir| dirs[dir] += 1 }

  n = dirs['n'] - dirs['s']
  ne = dirs['ne'] - dirs['sw']
  se = dirs['se'] - dirs['nw']
  
  distance(n, ne, se)
end

input = File.read('../input11.txt')
path = input.scan(/\w+/)

# Part 1
p path_length(path)

# Part 2
p (1...path.size).map { |i| path_length(path.take(i)) }.max


