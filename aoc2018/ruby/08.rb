input = File
  .read('../input/input08.txt')
  .scan(/\d+/)
  .map(&:to_i)

# input = %w[2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2].map(&:to_i)

Node = Struct.new(:remaining_children, :meta_length, :children, :metadata) do
  def initialize(remaining_children, meta_length, children=[], metadata=[])
    super
  end

  def value
    if children.empty?
      @value ||= metadata.sum
    else
      @value ||= metadata
        .map { |i| i - 1 }
        .select { |i| i < children.length }
        .sum { |i| children[i].value }
    end
  end
end

def read_tree(input)
  sum_metadata = 0

  remaining_children, meta_length, *rest = input
  root = Node.new(remaining_children, meta_length)
  stack = [root]

  loop do
    node = stack.last

    if node.remaining_children == 0
      metadata = rest.slice!(0, node.meta_length)
      node.metadata += metadata
      sum_metadata += metadata.sum
      stack.pop
    else
      node.remaining_children -= 1
      remaining_grandchildren, child_meta_length = rest.slice!(0, 2)
      child = Node.new(remaining_grandchildren, child_meta_length)
      node.children << child
      stack << child
    end

    break if stack.empty?
  end

  return [sum_metadata, root]
end

sum_metadata, root = read_tree(input)

# Part 1
p sum_metadata

# Part 2
p root.value 
