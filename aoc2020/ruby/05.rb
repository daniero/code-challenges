seat_ids = File
  .read('../input/05.txt')
  .scan(/([FB]+)([LR]+)/)
  .map { |row,col|
    r = row.tr('FB','01').to_i(2)
    c = col.tr('LR','01').to_i(2)
    r * 8 + c
  }


# Part 1

p seat_ids.max


# Part 2

seat_ids.sort.each_cons(2) do |a,b|
  if (a != b-1)
    puts a + 1
    break
  end
end

