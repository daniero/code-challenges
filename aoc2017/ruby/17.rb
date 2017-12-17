INPUT = 363

# Part 1

array = [0]
pos = 0

2017.times do |i|
  pos = (pos + INPUT + 1) % array.length
  array[pos,0] = i+1
end

p array.rotate[pos]

# Part 2
# Linked list are faster?

class List
  attr_accessor :elm, :next

  def initialize(elm)
    @elm = elm
  end

  def insert(nxt)
    nxt.next = @next
    @next = nxt
  end
end

root = List.new(0)
root.next = root

curr = root

50_000_000.times do |i|
  INPUT.times { curr = curr.next }
  curr.insert(List.new(i+1))
  curr = curr.next
end

curr = curr.next until curr.elm == 0
p curr.next.elm
