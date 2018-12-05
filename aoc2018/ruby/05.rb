input = File.read('../input/input05.txt').chomp

ALL_UNITS = Regexp.new(
  ('a'..'z')
    .flat_map { |c| [c+c.upcase, c.upcase+c] }
    .join('|')
)

def reaction(polymer)
  result = polymer.dup
  loop do
    result.gsub!(ALL_UNITS, '')
    break unless $&
  end
  result
end

# Part 1:
puts reaction(input).size

# Part 2:
puts ('a'..'z')
  .lazy
  .map { |c| input.delete(c+c.upcase) }
  .map { |polymer| reaction(polymer) }
  .map(&:size)
  .min
