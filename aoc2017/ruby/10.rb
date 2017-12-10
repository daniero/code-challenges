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

begin :part1
  input = File.read('../input10.txt').split(',').map(&:to_i)
  knot = Knot.new(input)
  a,b,*_ = knot.hash!
  puts a * b
end
