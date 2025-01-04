def run(gates, values)
  gates = gates.dup
  values = values.dup

  until gates.empty? do
    gates
      .select { |_,(in1, in2, _)| values[in1] && values[in2] }
      .each { |out,(in1, in2, op)|
        values[out] = op.call(values[in1], values[in2])
        gates.delete(out)
      }
  end

  values
end


input = File.read('../input/24.txt')

values = {}
input.scan(/(\w+): (\d)/) { values[$1] = $2.to_i }

ops = {
  "XOR" => lambda { _1 ^ _2 },
  "OR" => lambda { _1 | _2 },
  "AND" => lambda { _1 & _2 }
}

gates = {}
input.scan(/(\w+) (XOR|OR|AND) (\w+) -> (\w+)/) { gates[$4] = [$1, $3, ops[$2]] }

# Part 1
p run(gates, values)
  .select { |key,_| key.start_with?('z') }
  .sort.reverse
  .map(&:last)
  .join.to_i(2)
