class WeirdInt
  attr_reader :value

  def initialize value
    @value = value
  end

  def + m
    WeirdInt.new(@value * m.value)
  end

  def * m
    WeirdInt.new(@value + m.value)
  end
end

p File
  .open(ARGV[0] || '../input/18.txt')
  .map { |line| line.gsub(/(\d+)/) { "WeirdInt.new(#$1)" } }
  .map { |line| eval line.tr('+*', '*+') }
  .sum(&:value)


