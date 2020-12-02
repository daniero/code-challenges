input = File
  .readlines('../input/01.txt')
  .map(&:to_i)

puts input
  .combination(2)
  .find { |a,b| a + b === 2020 }
  .then { |a,b| a * b }

puts input
  .combination(3)
  .find { |a,b,c| a + b + c === 2020 }
  .then { |a,b,c| a * b * c }
