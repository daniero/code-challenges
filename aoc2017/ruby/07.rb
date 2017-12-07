input = File.read('../input07.txt')
            .scan(/^(\w+) \((\d+)\)\s*(?:->\s+([a-z, ]+))?$/)
            .map { |name, weight, children|
              [name, weight.to_i, (children||'').split(', ')]
            }


# Part 1
children, parents = (input.flat_map { |parent, _, children| children.map { |child| [child, parent] } }).transpose

puts (parents - children).uniq

