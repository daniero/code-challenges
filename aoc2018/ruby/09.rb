N_PLAYERS = 458
LAST_MARBLE = 71307

class Marble
  attr_reader :number
  attr_accessor :left, :right

  def initialize(number, left=self, right=self)
    @number = number
    @left = left
    @right = right
  end

  def insert_right(new_marble)
    new_marble.left = self
    new_marble.right = right
    right.left = new_marble
    @right = new_marble
  end

  def delete_left
    left.left.right = self
    @left = left.left
  end

  def place_marble(n)
    if (n % 23 == 0)
      to_remove = 7.times.reduce(self) { |marble, _| marble.left }
      points = to_remove.number
      new_current = to_remove.right
      new_current.delete_left
      [new_current, points + n]
    else
      new_marble = Marble.new(n)
      right.insert_right(new_marble)
      [new_marble, 0]
    end
  end

  def print_circle(start=@number)
    current = self

    loop do
      print "#{current.number} "
      current = current.right
      break if current == self
    end

    puts
  end
end


def solve(n_players, max_value)
  players = Array.new(n_players) { 0 }
  current = Marble.new(0)

  max_value.times do |i|
    (current, points) = current.place_marble(i+1)
    players[i % n_players] += points
  end

  players.max
end


puts solve(N_PLAYERS, LAST_MARBLE)
puts solve(N_PLAYERS, LAST_MARBLE*100)
