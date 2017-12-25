def distance(n, ne, se)
  [n, ne, se].map(&:abs).sort.drop(1).sum
end

input = File.read('../input/input11.txt')
path = input.scan(/\w+/)

n, ne, se = 0, 0, 0
max_distance = 0

path.each { |dir|
  case dir
  when 'n'; n+=1
  when 's'; n-=1
  when 'ne'; ne+=1
  when 'sw'; ne-=1
  when 'se'; se+=1
  when 'nw'; se-=1
  end

  max_distance = [max_distance, distance(n, ne, se)].max
}

p distance(n, ne, se)
p max_distance
