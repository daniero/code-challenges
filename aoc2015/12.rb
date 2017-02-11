input = File.read('input/12.json')

part1 =
  input
  .scan(/-?[0-9]+/)
  .map(&:to_i)

p part1.reduce(:+)

require 'json'

def extract(foo)
  return [foo] if foo.is_a? Integer
  return foo.flat_map { |f| extract f } if foo.is_a? Array

  return [] unless foo.is_a? Hash
  return [] if foo.values.include? "red"

  foo.flat_map { |key, value| extract value }
end

part2 = extract JSON.parse(input)
p part2.reduce(:+)
