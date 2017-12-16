def dance(moves)
  moves.map { |move|
    case move
    when /s(\d+)/
      x = -$1.to_i
      ->(a) { a.rotate x }
    when /x(\d+)\/(\d+)/
      x,y = $1.to_i, $2.to_i
      ->(a) { a[x], a[y] = a[y], a[x] }
    when /p(.)\/(.)/
      x,y = $1,$2
      ->(a) {
        i = a.index x
        j = a.index y
        a[i], a[j] = a[j], a[i]
      }
    end
  }
end

# Part 1

input = File.read('../input16.txt').split(',')
original_order = [*'a'..'p']

dance = dance(input)

programs = original_order.dup
dance.each { |m| m[programs] }

puts programs.join

# Part 2

programs = original_order.dup
visited = {}
cycle = nil

0.step do |i|
  if visited[programs]
    cycle = i - visited[programs]
    break
  end

  visited[programs.dup] = i
  dance.each { |m| m[programs] }
end

puts visited.key(1_000_000_000 % cycle).join
