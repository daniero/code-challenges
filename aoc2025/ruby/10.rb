machines = File
  #.readlines('../input-sample10.txt')
  .readlines('../input-real10.txt')
  .map { |line|
    a,b,c = line.split(/(?<=\])\s|\s(?=\{)/)

    lights = a.scan(/[.#]/).map { it == '#' ? 1 : 0 }

    buttons = b.split.map {
      toggles = it.scan(/\d+/).map(&:to_i)
      lights.size.times.map { |light|
        toggles.include?(light) ? 1 : 0
      }
    }

    joltage = c.scan(/\d+/).map { it.to_i }

    [lights, buttons, joltage]
  }


def part1(target, buttons, _)
  all_lights_off = target.map { 0 }
  configurations = {all_lights_off => 0}

  buttons.each { |button|
    new_configurations = {}

    configurations.each { |configuration,steps|
      new_configuration = [configuration,button].transpose.map { it.reduce :^ } 

      old = configurations[new_configuration]
      if !old || old > steps+1
        new_configurations[new_configuration] = steps+1
      end
    }

    configurations.merge! new_configurations
  }

  configurations[target]
end


def part2(_, buttons, target)
  all_lights_off = target.map { 0 }
  queue = [[all_lights_off, 0]]
  visited = Set[]

  loop do
    state,steps = queue.pop
    next unless visited.add? state

    buttons.each { |button|
      next_state = state.zip(button).map(&:sum)
      return steps+1 if next_state == target
      next if next_state.zip(target).any? { |n,t| n > t }

      queue.push [next_state,steps+1]
    }
  end
end


puts machines
  .map {
    puts
    p it
    p [part1(*it), part2(*it)] }
  .transpose
  .map(&:sum)
