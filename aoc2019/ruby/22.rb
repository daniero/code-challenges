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

input = File.read('../input/input22.txt')

# Part 1
n_cards = 10007
cards = [*0...n_cards]
cards = shuffle(cards, input)
p cards.index(2019)
