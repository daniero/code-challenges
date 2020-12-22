cards = File
  .read('../input/22.txt')
  .split("\n\n")
  .map { |chunk| chunk.lines.drop(1).map(&:to_i) }


players = cards.map(&:dup)

while players.none? &:empty?
  a,b = players.map(&:shift)
  if a > b
    players[0].push a, b
  else
    players[1].push b, a
  end
end


p players
  .reject(&:empty?)
  .first
  .reverse
  .each_with_index
  .sum { |card, i| card * (i+1) }
