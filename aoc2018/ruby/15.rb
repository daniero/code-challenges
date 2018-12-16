require 'set'

ATTACK = 3
HEALTH = 200

Unit = Struct.new(:x, :y, :team, :hp)

def read_input(filename)
  units = Set[]
  walls = Set[]
  height = 0
  width = 0

  File.open(filename).each_line.with_index do |row, y|
    row.chomp.each_char.with_index do |cell, x|
      if cell == 'E'
        units << Unit.new(x,y, :elf, HEALTH)
      elsif cell == 'G'
        units << Unit.new(x,y, :goblin, HEALTH)
      elsif cell == '#'
        walls << [x,y]
      end
      width = x + 1
    end
    height = y + 1
  end

  return units, walls.freeze, width, height
end

def adjecent_squares(x, y)
  Set[
    [x, y-1], # top
    [x-1, y], # left
    [x+1, y], # right
    [x, y+1]  # bottom
  ]
end

def tick(units, walls)
  in_order = units.sort_by { |unit| [unit.y, unit.x] }

  in_order.each do |current_unit|
    next if current_unit.hp <= 0

    friends, enemies = units
      .select { |that| that != current_unit && that.hp > 0 }
      .partition { |other| other.team == current_unit.team }

    return :game_over if enemies.empty?

    move(current_unit, enemies, friends, walls)
  end
end

def move(unit, enemies, friends, walls)
  next_position = move_towards_enemy(unit, enemies, walls, friends)
  return if next_position.nil?

  unit.x, unit.y = *next_position

  enemies_in_range = enemies.select { |enemy|
    adjecent_squares(enemy.x, enemy.y).include?(next_position)
  }

  unless enemies_in_range.empty?
    target = enemies_in_range.min_by { |enemy| [enemy.hp, enemy.y, enemy.x] }
    target.hp -= ATTACK
  end
end

def move_towards_enemy(unit, enemies, walls, friends)
  current_position = [unit.x, unit.y]
  target_squares = Set[]
  obstacles = Set[]
    .merge(walls)
    .merge(friends.map { |f| [f.x, f.y] })
    .merge(enemies.map { |e| [e.x, e.y] })

  enemies.each do |enemy|
    adjecent = adjecent_squares(enemy.x, enemy.y)
    in_range = adjecent.include?(current_position)

    return current_position if in_range
      
    adjecent.each { |square|
      target_squares << square unless obstacles.include?(square)
    }
  end

  find_shortest_path(current_position, target_squares, obstacles)
end

def find_shortest_path(start, goals, obstacles)
  return start if goals.include?(start)

  visited = Set[]
  queue =
    adjecent_squares(*start)
      .reject { |pos| obstacles.include?(pos) }
      .map { |pos| [pos, pos] }

  i = 0
  until queue.empty?
    position, first_step  = queue.shift

    return first_step if goals.include?(position)
    next if visited.include?(position)

    visited.add(position)

    adjecent_squares(*position).each do |square|
      unless obstacles.include?(square)
        queue.push([square, first_step])
      end
    end
  end
end

def print_state(width, height, units, walls)
  puts height.times.map { |y|
    width.times.map { |x|
      next '#' if walls.include? [x,y]
      unit = units.find { |unit| unit.x == x && unit.y == y }
      next '·' unless unit && unit.hp > 0
      if unit.team == :elf
        "\e[31mE\e[0m"
      else
        "\e[32mG\e[0m"
      end
    }.join
  }.join("\n")
end

units, walls, width, height = read_input('../input/input15.txt')

rounds = 0
game_over = false

loop do
  print "\e[2J" # clear screen
  print "\rRound #{rounds} * "
  print "HP #{hp = units.sum { |unit| [0, unit.hp].max }} "
  print "= #{rounds * hp}\n"

  print_state(width, height, units, walls)
  break if game_over

  game_over = tick(units, walls) == :game_over
  rounds += 1 unless game_over
end

