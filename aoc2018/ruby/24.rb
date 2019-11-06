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

groups =
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

loop do

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
  break if groups.map(&:army).uniq.count == 1
end

pp groups.sum(&:units)
