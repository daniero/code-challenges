class Knot
  attr_reader :list

  def initialize(input)
    @input = input
    @list = [*0..255] 
    @position = 0
    @skip = 0
  end

  def hash!
    n = @list.size

    @input.each do |length|
      range = @position ... @position+length
      idx = range.map { |i| i % n }
      sublist = @list.values_at(*idx)

      sublist.reverse.zip(idx).each { |e,i| @list[i] = e }

      @position = (@position+length+@skip) % n
      @skip += 1
    end

    @list
  end
end

def knot_hash(input)
  bytes = input.bytes
  knot = Knot.new(bytes + [17, 31, 73, 47, 23])

  64.times { knot.hash! }

  list = knot.list
  blocks = list.each_slice(16).map { |block| block.reduce(:^) }

  blocks.map { |block| "%02x" % block }.join
end


if __FILE__ == $0
  begin :part1
    input = File.read('../input10.txt').split(',').map(&:to_i)
    knot = Knot.new(input)
    a,b,*_ = knot.hash!
    puts a * b
  end

  begin :part2
    input = File.read('../input10.txt').chomp
    puts knot_hash(input)
  end
end
