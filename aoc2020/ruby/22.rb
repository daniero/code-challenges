cards = File
  .read(ARGV[0] || '../input/22.txt')
  .split("\n\n")
  .map { |chunk| chunk.lines.drop(1).map(&:to_i) }


# Part 1

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


# Part 2

require 'set'

def recursive_combat(cards)
  players = cards.map(&:dup)
  visited_states = Set.new

  while players.none? &:empty?
    unless visited_states.add? players.map { |d| d.join(',') }.join(';')
      return [0, players]
    end

    a,b = players.map(&:shift)
    round_winner = nil

    if a <= players[0].length && b <= players[1].length
      round_winner,_ = recursive_combat([players[0].take(a), players[1].take(b)])
    else
      round_winner = a > b ? 0 : 1
    end

    if round_winner == 0
      players[0].push a, b
    else
      players[1].push b, a
    end
  end

  winner = 1 - players.index(&:empty?)
  return [winner, players]
end

winner, cards = recursive_combat(cards)

p cards[winner]
  .reverse
  .each_with_index
  .sum { |card, i| card * (i+1) }
