moves = File
  .readlines('../input-sample01.txt')
 #.readlines('../input-real01.txt')
  .map { it.tr('LR','-+').to_i }

print "Part 1: "

position = 50
zeroes = 0

moves.each do |move|
  position += move
  zeroes += 1 if position%100 == 0
end

p zeroes


print "Part 2: "

position = 50
zeroes = 0

moves.each do |move|
  dir = move <=> 0

  move.abs.times do
    position += dir
    zeroes += 1 if position%100 == 0
  end
end

p zeroes
