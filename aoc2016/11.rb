Configuration = Struct.new(:moves, :elevator, :floors, :prev) do
  def eql?(other)
    sort_floor = ->(floor) { floor.sort_by { |c| [c.isotope, c.class.name] } }

    elevator == other.elevator &&
      floors.zip(other.floors).all? { |a,b| sort_floor[a] == sort_floor[b] }
  end

  def hash
    elevator.hash ^ floors.hash
  end
end

Generator = Struct.new(:isotope)
Microchip = Struct.new(:isotope, :powered) do
  def safe?(generators, microchips)
    powered ||
    generators.empty? ||
      generators.none? { |g| g.isotope != isotope }
  end
end

def done?(configuration)
  configuration.floors[0..2].all? { |floor| floor.empty? }
end

def ok?(configuration)
  configuration.floors.all? do |floor|
    generators, microchips = floor.partition { |component| component.is_a? Generator }

    microchips.all? { |chip| chip.safe?(generators, microchips) }
  end
end

def check_power(components)
    generators, microchips = components.partition { |component| component.is_a? Generator }
    updated_microchips = microchips.map do |c|
      powered = generators.any? { |g| g.isotope == c.isotope }
      Microchip.new(c.isotope, powered)
    end

    generators + updated_microchips
end

def transistions(configuration)
  new_configurations = []

  moves, elevator, floors = *configuration
  from_floor = floors[elevator]

  # Floors to try
  [+1, -1].each do |direction|
    to_index = elevator + direction
    next if to_index < 0 || to_index >= 4

    to_floor = floors[to_index]

    # Things to move
    (1..2).each do |amount|
      next if amount > from_floor.size
      [*0...from_floor.size].combination(amount) do |take_indexes|
        take_components = from_floor.values_at(*take_indexes)

        in_elevator = check_power(take_components)
        leave = check_power(from_floor - take_components)

        new_configuration = Configuration.new(moves + 1, to_index, floors.dup)
        new_configuration.floors[elevator] = leave
        new_configuration.floors[to_index] = to_floor + in_elevator

        if ok?(new_configuration)
          new_configurations << new_configuration
        end

      end
    end
  end

  new_configurations
end

def read_start_configuration(filename)
  floors = File.open(filename).map do |line|
    components = line
      .scan(/(\w+) generator|(\w+)-compatible microchip/)
      .map { |gen, chip| (gen ? Generator.new(gen.to_sym) : Microchip.new(chip.to_sym)) }

    check_power(components)
  end
  Configuration.new(0, 0, floors)
end

require 'pp'
require 'set'

def search(*configurations)
  visited = Set.new
  trail = {}
  id = 0

  loop do
    configuration = configurations.shift

    # puts
    # pp configuration

    return configuration, trail if done?(configuration)

    trail[id] = configuration

    reachable = transistions(configuration)
    reachable.each do |new|
      next if visited.include? new

      # p :NEW
      # pp new
      new.prev = id
      visited << new
      configurations << new
    end

    id += 1
  end
end

conf, trail = search(read_start_configuration('input/11.txt'))

puts
puts

pp conf

puts
puts

n = conf
path = []
loop do
  path.unshift n
  n = trail[n.prev]

  break unless n
end

pp path

