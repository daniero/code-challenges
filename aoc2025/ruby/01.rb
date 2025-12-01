moves = pp File
 #.readlines('../input-sample01.txt')
  .readlines('../input-real01.txt')
  .map { it.tr('LR','-+').to_i }

position = 50
zeroes = 0

moves.each do |move|
  position += move
  zeroes += 1 if position%100 == 0
end

p zeroes
