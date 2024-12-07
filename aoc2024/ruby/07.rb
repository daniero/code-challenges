require 'set'

input = File
  .readlines('../input/07-sample.txt')
  .map { _1.scan(/\d+/).map(&:to_i) }


def dp(numbers)
  return numbers
    .drop(1)
    .reduce(Set[numbers.first]) { |prev_result,next_number|
      next_result = Set[]
      prev_result.each { |prev|
        next_result << prev + next_number
        next_result << prev * next_number
      }
      next_result
    }
end


pp input
  .filter { |result, *numbers|
    dp(numbers).include? result
  }.sum(&:first)
