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
  def safe?(generators)
    powered ||
    generators.empty? ||
      generators.any? { |g| g.isotope == isotope }
  end
end

def done?(configuration)
  configuration.floors[0..2].all? { |floor| floor.empty? }
end

def ok?(configuration)
  configuration.floors.all? do |floor|
    generators, microchips = floor.partition { |component| component.is_a? Generator }

    microchips.all? { |chip| chip.safe?(generators) }
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
  moves, elevator, floors = *configuration

  possible_elevators = []
  possible_elevators << elevator + 1 if elevator < 3
  possible_elevators << elevator - 1 if elevator > 0

  possible_amounts = [1, 2].select { |n| n <= floors[elevator].size }

  new_configurations = []

  possible_elevators.product(possible_amounts).each do |to_index, amount|
    from_floor = floors[elevator]
    to_floor = floors[to_index]

    from_floor.combination(amount) do |take_components|
      in_elevator = check_power(take_components)
      leave = check_power(from_floor - take_components)

      new_configuration = Configuration.new(moves + 1, to_index, floors.dup)
      new_configuration.floors[elevator] = leave
      new_configuration.floors[to_index] = check_power(to_floor) + in_elevator

      if ok?(new_configuration)
        new_configurations << new_configuration
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
require 'pqueue'

def search(*configurations)
  visited = Set.new
  weight = ->(c) { c.floors.map.with_index { |f,i| f.size * i } }
  queue = PQueue.new(configurations) { |a,b| weight[b] <=> weight[a] }
  trail = {}
  id = 0


  loop do
    configuration = queue.pop

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
      queue.push(new)
    end

    id += 1
    puts "#{id} states checked, #{queue.size} in queue" if id % 10_000 == 0
  end
end

# conf, trail = search(read_start_configuration('input/11_testcase.txt'))
conf, trail = search(read_start_configuration('input/11.txt'))

path = []
n = conf
while n
  path.unshift n
  n = trail[n.prev]
end

name = ->(c) { c.isotope.to_s[0].upcase + c.class.name[0] }
names = conf.floors.flat_map { |f| f.map(&name) }.sort

path.each do |n|
  puts "----" * names.size
  n.floors.reverse.each.with_index do |f,i|
    fn = f.map(&name)
    print names.map { |name| fn.include?(name) ? name : "  " } * " "
    print "  [E]" if i == 3 - n.elevator
    puts
  end
end

pp conf
