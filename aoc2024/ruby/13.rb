require 'set'

class Array
  def zmr(other)
    self.zip(other).map { _1.reduce { |x,y| yield x,y } }
  end
end

def calculate_prize(a, b, target)
  visited = Set[]
  queue = []
  queue << [0, [0,0]]

  until queue.empty? do
    cost, pos = queue.pop
    return cost if pos == target
    next unless visited.add? pos

    na = pos.zmr(a, &:+)
    nb = pos.zmr(b, &:+)

    queue.push [cost+1, nb] unless nb.zmr(target, &:>).any?
    queue.push [cost+3, na] unless na.zmr(target, &:>).any?
  end

  return 0
end


input = File
  .read('../input/13-sample.txt')
  .split("\n\n")
  .map { _1.scan(/\d+/).map(&:to_i).each_slice(2).to_a }


p input.sum { |a, b, target| calculate_prize(a, b, target) }
