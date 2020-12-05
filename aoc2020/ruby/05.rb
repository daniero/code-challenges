seat_ids = File
  .read('../input/05.txt')
  .scan(/[FB]+[LR]+/)
  .map { _1.tr('FBLR','0101').to_i(2) }


# Part 1

p seat_ids.max


# Part 2

seat_ids.sort.each_cons(2) do |a,b|
  if (a != b-1)
    puts a + 1
    break
  end
end

