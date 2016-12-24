INPUT = 3014387

# Part 1

elves = (1..INPUT).to_a

while elves.length > 1
  rest = elves.length % 2
  elves.select!.with_index { |_, i| i.even? }
  elves.shift(rest)
end

puts elves.first

# Part 2

Elf = Struct.new(:num, :next_elf) do
  def walk(n)
    elf = self
    n.times { elf = elf.next_elf }
    elf
  end

  # Having presents stolen == leaving the circle == being dropped
  def drop!
    self.next_elf = self.next_elf.next_elf
  end
end

def initialize_circle(n)
  first = Elf.new(1)
  last = first

  2.upto(n) do |i|
    new = Elf.new(i)
    last.next_elf = new
    last = new
  end

  last.next_elf = first
end

first = initialize_circle(INPUT)  # First elf to steal presents
dropper = first.walk(INPUT/2 - 1) # Elf sitting before the first elf having their presents stolen

n = INPUT
i = 0

(INPUT-1).times do
  dropper.drop!
  first = first.walk(1)
  n -= 1
  i += 1
  dropper = dropper.walk(i % 2)
end

p first.num
