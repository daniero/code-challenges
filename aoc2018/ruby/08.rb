input = File
  .read('../input/input08.txt')
  .scan(/\d+/)
  .map(&:to_i)

# input = %w[2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2].map(&:to_i)

def sum_metadata(tree)
  sum_metadata = 0

  n_children, metadata_length, *rest = tree
  root = [n_children, metadata_length]
  stack = [root]

  loop do
    skip, read = stack.pop

    if skip == 0
      metadata = rest.slice!(0, read)
      sum_metadata += metadata.sum
    else
      stack.push([skip-1, read])

      c,n = rest.slice!(0, 2)
      stack.push([c, n])
    end

    break if stack.empty?
  end

  return sum_metadata
end

p sum_metadata(input)
