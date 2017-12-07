input = File.read('../input07.txt')
            .scan(/^(\w+) \((\d+)\)\s*(?:->\s+([a-z, ]+))?$/)
            .map { |name, weight, children|
              [name, weight.to_i, (children||'').split(', ')]
            }


parents = input.flat_map { |parent, _, children| children.map { |child| [child, parent] } }.to_h

p input.map(&:first) - parents.keys
