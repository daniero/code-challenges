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

# Part 2

def expand(value)
  initial = [0]

  value.chars.reduce(initial) { |acc, char|
    if char == '1' || char == '0'
      acc.map { |a| (a << 1) + char.to_i }
    else
      acc.flat_map { |a| [(a << 1), (a << 1) + 1] }
    end
  }
end

def mask_value2(value, mask)
  value
    .to_s(2)
    .rjust(mask.size, '0')
    .chars
    .zip(mask)
    .map { |v,m| m == '0' ? v : m }
    .join
end

mask = ['0'] * BITS
mem = Hash.new { |h,k| h[k] = ['0'] * BITS }

instructions.each do |inst, a, b|
  case inst
  when :mask
    mask = a
  when :mem
    address = mask_value2(a, mask)
    expand(address).each { |e| mem[e] = b}
  end
end

p mem.values.sum { |v| v.join.to_i(2) }

