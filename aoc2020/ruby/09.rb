input = File
  .readlines('../input/09.txt')
  .map(&:to_i)


# Part 1
input.each_cons(25+1) do |*prev, current|
  complies_with_xmas = prev.combination(2).any? { |a,b| a + b == current }

  unless complies_with_xmas
    puts current
    break
  end
end

