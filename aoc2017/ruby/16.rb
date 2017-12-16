def dance(programs, moves)
  moves.each do |move|
    case move
    when /s(\d+)/
      programs.rotate! -$1.to_i
    when /x(\d+)\/(\d+)/
      a,b = $1.to_i, $2.to_i
      programs[a], programs[b] = programs[b], programs[a]
    when /p(.)\/(.)/
      i = programs.index $1
      j = programs.index $2
      programs[i], programs[j] = programs[j], programs[i]
    end
  end
end

# Part 1

input = File.read('../input16.txt').split(',')
original_order = [*'a'..'p']

programs = original_order.dup
dance(programs, input)
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
  dance(programs, input)
end

puts visited.key(1_000_000_000 % cycle).join
