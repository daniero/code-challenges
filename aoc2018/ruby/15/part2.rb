require_relative 'io'
require_relative 'logic'

def buff_elves(units, attack_buff)
  units.map { |unit|
    new_unit = unit.dup
    if new_unit.team == :elf
      new_unit.attack += attack_buff
    end
    new_unit
  }
end

def battle(units, walls, width, height, elf_attack)
  rounds = 0
  game_over = false

  loop do
    hp = units.sum { |unit| [0, unit.hp].max }
    result = rounds * hp

    print "\e[1;0H" # Move cursor to top left corner
    print "Att #{elf_attack} · "
    print "Round #{rounds} * "
    print "HP #{hp} "
    print "= #{result}\n"
    print_state(width, height, units, walls)

    break if units.any? { |unit| unit.team == :elf && unit.hp <= 0 }
    return result if game_over

    game_over = move_all_units(units, walls) == :game_over
    rounds += 1 unless game_over
  end
end


filename = ARGV[0] || '../../input/input15.txt'
units, walls, width, height = read_input(filename)

print "\e[2J" # clear screen

1.step do |attack_buff|
  modified_units = buff_elves(units, attack_buff)

  battle(modified_units, walls, width, height, ATTACK+attack_buff)

  sleep 1.5
  break if modified_units.all? { |unit| unit.hp > 0 || unit.team != :elf }
end
