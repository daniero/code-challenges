require 'set'

ATTACK = 3
HEALTH = 200

Unit = Struct.new(:x, :y, :team, :hp, :attack)

def read_input(filename)
  units = Set[]
  walls = Set[]
  height = 0
  width = 0

  File.open(filename).each_line.with_index do |row, y|
    row.chomp.each_char.with_index do |cell, x|
      if cell == 'E'
        units << Unit.new(x,y, :elf, HEALTH, ATTACK)
      elsif cell == 'G'
        units << Unit.new(x,y, :goblin, HEALTH, ATTACK)
      elsif cell == '#'
        walls << [x,y]
      end
      width = x + 1
    end
    height = y + 1
  end

  return units, walls.freeze, width, height
end

def print_state(width, height, units, walls)
  puts height.times.map { |y|
    width.times.map { |x|
      next '#' if walls.include? [x,y]

      units_at_spot = units.select { |unit| unit.x == x && unit.y == y }
      next '·' if units_at_spot.empty?

      alive_unit = units_at_spot.find { |unit| unit.hp > 0 }

      if alive_unit && alive_unit.team == :elf
        "\e[31mE\e[0m"
      elsif alive_unit
        "\e[32mG\e[0m"
      elsif units_at_spot.first.team == :elf
        "\e[31m✝\e[0m"
      else
        "\e[32m✝\e[0m"
      end
    }.join
  }.join("\n")
end
