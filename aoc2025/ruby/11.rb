to_from = Hash.new { |h,k| h[k] = Set[] }

from_to = File
  .readlines('../input-sample11.txt')
  .each {
    from, *to = it.scan(/\w+/)
    to.each { to_from[it] << from }
    [from, to]
  }

paths = Hash.new { 'you' => 1 }
queue = ['you']
visited = Set[]

until queue.empty?
  node = queue.pop
  visited << node

  n = paths[node]
  from_to[node].each { |to|
    paths[to] += n
  }
end
