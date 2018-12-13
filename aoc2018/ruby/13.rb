input = File.read('../input/input13.txt')

DIRECTIONS = {
  east: [1, 0],
  south: [0, 1],
  west: [-1, 0],
  north: [0, -1]
}

TURNS = {
  left: -1,
  straight: 0,
  right: 1,
}

Cart = Struct.new(:x, :y, :dir, :turns) do
  def initialize(*args)
    super
    self.turns ||= [:left, :straight, :right]
  end

  def turn_corner(*changes)
    self.dir = (changes + changes.map(&:reverse)).assoc(dir).last
  end

  def turn_intersection
    current_dir_index = DIRECTIONS.keys.index(dir)
    next_turn = TURNS[self.turns.first]

    self.dir = DIRECTIONS.keys[(current_dir_index + next_turn) % DIRECTIONS.size]
    self.turns.rotate!
  end
end

carts = []

tracks = input.lines.map.with_index { |line, y|
  line.chars.map.with_index { |char, x|
    case char
    when '>'
      carts << Cart.new(x, y, :east)
      '-'
    when '<'
      carts << Cart.new(x, y, :west)
      '-'
    when '^'
      carts << Cart.new(x, y, :north)
      '|'
    when 'v'
      carts << Cart.new(x, y, :south)
      '|'
    else
      char
    end
  }.join
}

loop do
  carts.sort_by! { |cart| [cart.y, cart.x] }

  carts.each do |cart|
    direction = DIRECTIONS[cart.dir]
    new_x = cart.x + direction[0]
    new_y = cart.y + direction[1]

    if carts.any? { |other| other.x == new_x && other.y == new_y }
      puts "Collision at (#{new_x},#{new_y})!"
      exit
    end

    cart.x = new_x
    cart.y = new_y

    case tracks[new_y][new_x]
    when '/'
      cart.turn_corner [:east, :north], [:west, :south]
    when '\\'
      cart.turn_corner [:east, :south], [:west, :north]
    when '+'
      cart.turn_intersection
    end
  end
end
