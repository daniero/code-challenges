File
  .readlines('../input/01.txt')
  .map(&:to_i)
  .combination(2)
  .find { |a,b| a + b === 2020 }
  .then { |a,b| puts a * b }
