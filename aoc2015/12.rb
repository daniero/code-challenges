part1 =
  File.read('input/12.json')
  .scan(/-?[0-9]+/)
  .map(&:to_i)

p part1.reduce(:+)
