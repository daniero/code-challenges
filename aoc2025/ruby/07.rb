require "set"

start, *rows = File.readlines('../input-sample07.txt')
start, *rows = File.readlines('../input-real07.txt')

beams = Hash.new { |h,k| h[k] = 0 }
beams[start.index("S")] = 1
splits = 0

puts start
rows.each { |row|
  current = [*beams]
  p current
  puts row

  current.each { |beam, count|
    if row[beam] == "^"
      splits+=1
      beams[beam] = 0
      beams[beam-1]+=count
      beams[beam+1]+=count
    end
  }
}

p splits
p beams.values.sum
