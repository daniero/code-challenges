input = File.readlines('../input/input22.txt').map(&:chomp)

DIRECTIONS = [
  [0, -1], # Up
  [1, 0], # Right
  [0, 1], # Down
  [-1, 0] # Left
]

original_grid = Hash.new { false }

input.each_with_index do |line, y|
  line.chars.each_with_index do |c, x|
    original_grid[[x,y]] = c == '#'
  end
end

dir = 0
pos = [input.size/2] * 2

# Part 1

Virus = Struct.new(:dir, :pos, :grid, :new_infections) do
  def burst
    state = grid[pos]

    new_state = alter_state(state)
    grid[pos] = new_state

    self.new_infections+= 1 if count_new_infections(new_state)

    self.dir+= turn(state)
    move()
  end

  def alter_state(state)
    !state
  end

  def count_new_infections(state)
    state
  end

  def turn(state)
    state ? 1 : -1
  end

  def move()
    self.pos = self.pos.zip(DIRECTIONS[dir%4]).flat_map { |a,b| a + b }
  end
end

grid = original_grid.dup
virus = Virus.new(dir, pos, grid, 0)

(10_000).times { virus.burst }
p virus.new_infections

# Part 2

class EvolvedVirus < Virus
  def burst
    state = grid[pos]

    new_state = alter_state(state)
    grid[pos] = new_state

    self.new_infections+= 1 if count_new_infections(new_state)

    self.dir = turn(state)
    move()
  end

  def count_new_infections(state)
    state == :infected
  end

  def alter_state(state)
    case state
    when :clean
      :weakened
    when :weakened
      :infected
    when :infected
      :flagged
    when :flagged
      :clean
    else
      raise "next state: current state: #{state}"
    end
  end

  def turn(state)
    case state
    when :clean
      dir - 1      # left
    when :weakened
      dir          # same
    when :infected
      dir + 1      # right
    when :flagged
      dir + 2      # back
    else
      raise "turn: current state: #{state}"
    end
  end

end

nu_grid = Hash.new { :clean }.merge(original_grid.transform_values { |v| v ? :infected : :clean })

evolved_virus = EvolvedVirus.new(dir, pos, nu_grid, 0)

10_000_000.times { evolved_virus.burst }
p evolved_virus.new_infections

__END__
  ..#
#..
  ...
