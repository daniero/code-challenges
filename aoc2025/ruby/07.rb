require "set"

start, *rows = File.readlines('../input-sample07.txt')
#start, *rows = File.readlines('../input-real07.txt')

initial = [start.index("S")]
splits = 0

puts start
rows.reduce(initial) { |beams, row|
  x = beams.flat_map { |beam|
    if row[beam] == "^"
      splits+=1
      [beam-1, beam+1]
    else
      [beam]
    end
  }
  x.each { |i| row[i] = "|" }
  puts row
  x.to_set
}

p splits
