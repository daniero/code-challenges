require 'set'

Group = Struct.new(:army, :number, :units, :hitpoints, :immunities, :weaknesses, :damage, :attack_type, :initiative, :target) do
  def id
    [army, number]
  end

  def effective_power
    units * damage
  end

  def effective_damage(enemy)
    if enemy.weaknesses.include?(attack_type)
      effective_power * 2
    elsif enemy.immunities.include?(attack_type)
      0
    else
      effective_power
    end
  end
end

def status(groups)
  groups.map { |g| [g.army, g.number, g.units] }
end

def battle(input)
  groups = input.map(&:dup)

  loop do
    status_before = status(groups)

    # Target selection phase

    targeted = Set[]
    groups.each { |g| g.target = nil }

    groups
      .sort_by { |group| [group.effective_power, group.initiative] }.reverse
      .each { |attacker|
      attacker.target = groups
        .select { |target|
        target.army != attacker.army &&
          attacker.effective_damage(target) > 0 &&
          !targeted.include?(target.id)
      }
        .max_by { |target|
        [
          attacker.effective_damage(target),
          target.effective_power,
          target.initiative
        ]
      }
      targeted << attacker.target.id if attacker.target
    }

    # Attack phase

    groups
      .reject { |group| !group.target }
      .sort_by(&:initiative).reverse
      .each { |attacker|
      next if attacker.units == 0

      target = attacker.target
      damage = attacker.effective_damage(target)
      kills = [damage / target.hitpoints, target.units].min
      target.units -= kills
      attacker.target = nil

      #p [attacker.army, attacker.number, target.army, target.number, damage, kills]
    }

    groups.reject! { |group| group.units == 0 }

    return nil if status(groups) == status_before
    return groups if groups.uniq(&:army).count == 1
  end
end


input =
  File.read(ARGV[0] || '../input/input24.txt')
    .split(/\n{2}/m)
    .map { |x| x.lines.drop(1) }
    .flat_map.with_index { |section, section_index|
      section.map.with_index { |line, linenum|
        Group.new(
          [:immune_system, :infection][section_index],
          linenum+1,
          line[/(\d+)(?= units)/].to_i,
          line[/(\d+)(?= hit points)/].to_i,
          line[/(?<=immune to )([a-z, ]+)/]&.split(/, /)&.map(&:to_sym) || [],
          line[/(?<=weak to )([a-z, ]+)/]&.split(/, /)&.map(&:to_sym) || [],
          line[/(?<=attack that does )(\d+)/].to_i,
          line[/(\w+)(?= damage)/]&.to_sym,
          line[/(?<=initiative )(\d+)/].to_i,
        )
      }
    }


puts "Part 1"
p battle(input).sum(&:units)


puts
puts "Part 2"

result = nil;
1.step.find { |boost|
  print "\rBoost:#{boost}"

  input.each { |group| group.damage += 1 if group.army == :immune_system }

  result = battle(input)
  result&.first&.army == :immune_system
}
puts
puts result.sum(&:units)
