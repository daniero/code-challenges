input = File
  .readlines(ARGV[0] || '../input/04.txt')
  .map { |line| line.scan(/\d+/).map(&:to_i) }

numbers = input.first

boards = input
  .drop(1)
  .slice_before(&:empty?)
  .map { |chunk| chunk.drop(1) }
  .to_a

def bingo?(numbers, board)
  board.any? { |row| row.all? { |number| numbers.include?(number) } } ||
  board.transpose.any? { |col| col.all? { |number| numbers.include?(number) } }
end


# Part 1:

bingo = nil
draws = []

numbers.each do |n|
  draws.push(n)

  bingo = boards.find { |board| bingo?(draws, board) }
  break if bingo
end

unmarked = bingo.flat_map { |row| row.reject { |number| draws.include?(number) } }

p unmarked.sum * draws.last


# Part 2:

draws = []

while boards.length > 1
  draws.push(numbers.shift)
  boards.reject! { |board| bingo?(draws, board) }
end

last_board = boards[0]

loop do
  draws.push(numbers.shift)
  break if bingo?(draws, last_board)
end

unmarked = last_board.flat_map { |row| row.reject { |number| draws.include?(number) } }

p unmarked.sum * draws.last
