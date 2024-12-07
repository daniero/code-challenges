require 'set'

input = File
  .readlines('../input/07-sample.txt')
  .map { _1.scan(/\d+/).map(&:to_i) }


def dp(numbers)
  return numbers
    .drop(1)
    .reduce(Set[numbers.first]) { |prev_nums,next_num|
      prev_nums.reduce(Set[]) { |acc,prev_num| acc.merge(yield prev_num, next_num) }
    }
end


p input.filter { |result, *numbers|
    dp(numbers) { |a,b| [a+b, a*b] }.include? result
  }.sum(&:first)

p input.filter { |result, *numbers|
    dp(numbers) { |a,b| [a+b, a*b, "#{a}#{b}".to_i] }.include? result
  }.sum(&:first)
