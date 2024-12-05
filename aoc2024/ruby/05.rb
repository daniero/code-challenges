require 'set'

input = File.read('../input/05-sample.txt')

order = Hash.new { |h,k| h[k] = Set[] }
input.scan(/(\d+)\|(\d+)/) { order[$1.to_i] << $2.to_i }

updates = input[/(?<=\n\n).*/m].lines.map { _1.scan(/\d+/).map &:to_i }

correct = updates.filter { |update|
  update.map.with_index.all? { |page,i|
    update[0...i].none? { |before| order[page].include? before }
  }
}

# Part 1
p correct.sum { _1[_1.length/2] }
