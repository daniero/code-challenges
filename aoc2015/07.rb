input = File.open('input/07.txt').each_line.map(&:chomp)
wires = {}

get = ->(k) { Integer(k) rescue wires[k] }

loop do
  n = wires.size

  input.reject! { |line|
    case line
    when /^(\w+) -> (\w+)/
      wires[$2] = get[$1]

    when /NOT (\w+) -> (\w+)/
      a = get[$1]
      next unless a
      wires[$2] = ~a & 2**16-1

    when /(\w+) LSHIFT (\d+) -> (\w+)/
      a = get[$1]
      next unless a
      wires[$3] = a << $2.to_i

    when /(\w+) RSHIFT (\d+) -> (\w+)/
      a = get[$1]
      next unless a
      wires[$3] = a >> $2.to_i

    when /(\w+) AND (\w+) -> (\w+)/
      a, b = get[$1], get[$2]
      next unless a && b
      wires[$3] = a & b

    when /(\w+) OR (\w+) -> (\w+)/
      a, b = wires.values_at($1, $2)
      next unless a && b
      wires[$3] = a | b
      
    else
      raise line
    end
  }

  break if wires.size == n
end

p wires['a']
