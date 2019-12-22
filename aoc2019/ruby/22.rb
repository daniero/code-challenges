def shuffle(cards, instructions)
  instructions.lines.each do |instruction|
    case instruction
    when /deal into new stack/
      cards.reverse!
    when /cut (\-?\d+)/
      cards.rotate!($1.to_i)
    when /deal with increment (\d+)/
      inc = $1.to_i
      tmp = []
      cards.each_with_index { |card, i| tmp[i*inc%cards.size] = card }
      cards = tmp
    else
      raise 'hm?'
    end
  end

  cards
end

def track_card(card, n_cards, instructions)
  instructions.lines.each do |instruction|
    case instruction
    when /deal into new stack/
      card = n_cards - 1 - card
    when /cut (\-?\d+)/
      card = (card - $1.to_i % n_cards)
    when /deal with increment (\d+)/
      card = (card * $1.to_i % n_cards)
    else
      raise 'hm?'
    end
  end

  return card
end


input = File.read('../input/input22.txt')

# Part 1
n_cards = 10007
cards = [*0...n_cards]
cards = shuffle(cards, input)
p cards.index(2019)
p track_card(2019, n_cards, input)


puts

card = 2019
(n_cards-1).times { card = track_card(card, n_cards, input) }
p card
1.times { card = track_card(card, n_cards, input) }
p card

puts

card = 2019
history = Hash.new { 0 }
(n_cards-1).times { card = track_card(card, n_cards, input); history[card] += 1 }
p card
p history.values.uniq
1.times { card = track_card(card, n_cards, input); history[card] += 1 }
p card
p history.values.uniq


exit


# Part 2
n_cards =  119315717514047
shuffles = 101741582076661
moves = track_card(2020, n_cards, input)
