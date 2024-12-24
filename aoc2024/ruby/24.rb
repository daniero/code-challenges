input = File.read('../input/24.txt')

values = {}
input.scan(/(\w+): (\d)/) { values[$1] = $2.to_i }

gates = {}
input.scan(/(\w+) (XOR|OR|AND) (\w+) -> (\w+)/) { gates[$4] = [$1, $3, $2] }

def eval_out(a, b, op)
  case op
  when "XOR"; a^b
  when "OR"; a|b
  when "AND"; a&b
  else; raise "invalid operator #{op}"
  end
end

until gates.empty? do
  gates
    .select { |_,(in1, in2, _)| values[in1] && values[in2] }
    .each { |out,(in1, in2, op)|
      values[out] = eval_out(values[in1], values[in2], op)
      gates.delete(out)
    }
end

p values
  .select { |key,_| key.start_with?('z') }
  .sort.reverse
  .map(&:last)
  .join.to_i(2)
