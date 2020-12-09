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

# Part 2
[*0...input.length]
  .combination(2)
  .lazy
  .map { |a,b| input.values_at(a..b) }
  .find { |range| range.sum == 1492208709 }
  .then(&:minmax)
  .then { |min,max| puts min + max }
