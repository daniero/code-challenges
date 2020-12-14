BITS = 36

instructions = File
  .readlines(ARGV[0] || '../input/14.txt')
  .map { |line|
    case line
    when /mask = ([01X]+)/
      [:mask, $1.chars]
    when /mem\[(\d+)\] = (\d+)/
      [:mem, $1.to_i, $2.to_i.to_s(2).rjust(BITS, '0').chars]
    else
      raise "??? " + line
    end
  }


# Part 1

def mask_value(value, mask)
  value.zip(mask).map { |v,m|
    m == 'X' ? v : m
  }
end

mask = ['0'] * BITS
mem = {}

instructions.each do |inst, a, b|
  case inst
  when :mask
    mask = a
  when :mem
    mem[a] = mask_value(b, mask)
  end
end

p mem.values.sum { |v| v.join.to_i(2) }
