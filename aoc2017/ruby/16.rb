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

input = File.read('../input16.txt').split(',')

programs = [*'a'..'p']
dance(programs, input)
puts programs.join
