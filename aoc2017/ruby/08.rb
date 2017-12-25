registers = Hash.new { 0 }

class << registers
  attr_reader :highest_ever

  def []=(key, value)
    @highest_ever = value if !@highest_ever || value > @highest_ever
    super
  end
end

File.read('../input/input08.txt')
    .gsub(/^\w+|(?<=if )\w+/) { "registers['#$&']" }
    .gsub(/inc/, '+=')
    .gsub(/dec/, '-=')
    .each_line { |line| eval(line) }

puts registers.values.max
puts registers.highest_ever

