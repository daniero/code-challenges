input = File.readlines('../input/input22.txt').map(&:chomp)
#input = DATA.readlines.map(&:chomp)

DIRECTIONS = [
  [0, -1], # Up
  [1, 0], # Right
  [0, 1], # Down
  [-1, 0] # Left
]

Virus = Struct.new(:dir, :pos, :grid, :original, :new_infections) do
  def burst
    infected = grid[pos]

    new_state = !infected
    grid[pos] = new_state

    if (new_state)
      self.new_infections+= 1
    end

    self.dir+= new_state ? -1 : 1
    self.pos = self.pos.zip(DIRECTIONS[dir%4]).flat_map { |a,b| a + b }
  end
end

original = Hash.new { false }

input.each_with_index do |line, y|
  line.chars.each_with_index do |c, x|
    original[[x,y]] = c == '#'
  end
end

dir = 0
pos = [input.size/2] * 2

virus = Virus.new(dir, pos, original.dup, original, 0)

(10_000).times { virus.burst }
p virus.new_infections
