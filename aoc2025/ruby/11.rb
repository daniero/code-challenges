$nodes = File
  #.readlines('../input-sample11.txt')
  .readlines('../input-real11.txt')
  .to_h {
    from, *to = it.scan(/\w+/)
    [from, to]
  }

$paths = {}

def solve(from)
  return 1 if from == "out"

  nodes = $nodes[from]
  return 0 unless nodes

  $paths[from] = nodes.sum { |to|
    $paths[to] || solve(to)
  }
end

puts solve("you")
