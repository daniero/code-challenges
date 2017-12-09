input = File.read('../input07.txt')
            .scan(/^(\w+) \((\d+)\)\s*(?:->\s+([a-z, ]+))?$/)
            .map { |name, weight, children|
              [name, weight.to_i, (children||'').split(', ')]
            }


parents = input.flat_map { |parent, _, children| children.map { |child| [child, parent] } }.to_h

# Part 1
root = (input.map(&:first) - parents.keys).first
puts root

# Part 2

Node = Struct.new(:name, :weight, :children) do
  def total_weight
    weight + children.sum(&:total_weight)
  end
end

nodes = Hash.new { |h,name| h[name] = Node.new(name, nil, []) }

input.each { |name, weight, children|
  node = nodes[name]
  node.weight = weight
  node.children+= children.map { |child| nodes[child] }
}

# Manual inspection is faster:

puts
p nodes[root].total_weight
p nodes[root].children.map(&:total_weight)
p nodes[root].children.last.weight
p nodes[root].children.last.children.map(&:total_weight)
p nodes[root].children.last.children[2].children.map(&:total_weight)
p nodes[root].children.last.children[2].children[3].children.map(&:total_weight)
p nodes[root].children.last.children[2].children[3].weight
puts

p 1531-(1531-(2255-243*3))
