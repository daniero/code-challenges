# Input: [Start value, factor]
A = [703, 16807]
B = [516, 48271]

DIVISOR = 2147483647

def create_generator(value, factor)
  Enumerator.new do |y|
    loop do
      y <<  value = (value * factor) % DIVISOR
    end
  end
end

a = create_generator(*A)
b = create_generator(*B)

bit_mask = 2**16-1

# Part 1

p 40_000_000.times.count { a.next & bit_mask == b.next & bit_mask }

# Part 2

a.rewind
b.rewind

a2 = a.lazy.select { |i| i % 4 == 0}
b2 = b.lazy.select { |i| i % 8 == 0}

p 5_000_000.times.count { a2.next & bit_mask == b2.next & bit_mask }
