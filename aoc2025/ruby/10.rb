machines = File
  .readlines('../input-sample10.txt')
  .map { |line|
    a,b,c = line.split(/(?<=\])\s|\s(?=\{)/)

    lights = a.scan(/[.#]/).map { it == '#' }
    buttons = b.split.map { it.scan(/\d+/).map(&:to_i) }
    joltage = c.scan(/\d+/).map { it.to_i }

    [lights, buttons, joltage]
  }

def part1(lights, buttons, joltage)
  # todo
  42
end

pp machines
puts machines.sum { part1(*it) }
