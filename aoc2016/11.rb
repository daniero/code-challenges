Configuration = Struct.new(:moves, :elevator, :floors)

Generator = Struct.new(:isotope)
Microchip = Struct.new(:isotope) do
  def safe?(generators)
    generators.empty? || generators.any? { |g| g.isotope == isotope }
  end
end

def done?(configuration)
  configuration[0..2].all? { |floor| floor.empty? }
end

def ok?(configuration)
  configuration.floors.all? do |floor|
    generators, microchips = floor.partition { |component| component.is_a? Generator }

    microchips.all? { |chip| chip.safe?(generators) }
  end
end

def transistions(configuration)
  new_configurations = []

  moves, elevator, floors = *configuration
  from_floor = floors[elevator]

  # Floors to try
  [+1, -1].each do |direction|
    to_index = elevator + direction
    next unless to_index >= 0 && to_index <= 4

    to_floor = floors[to_index]

    # Things to move
    (1..2).each do |amount|
      [*0...from_floor.size].combination(amount) do |take_indexes|
        take_components = from_floor.values_at(*take_indexes)

        new_configuration = Configuration.new(moves + 1, to_index, floors.dup)
        new_configuration.floors[elevator] = from_floor - take_components
        new_configuration.floors[to_index] = to_floor + take_components

        if ok?(new_configuration)
          new_configurations << new_configuration
        end

      end
    end
  end

  new_configurations
end

def read_start_configuration
  floors = File.open('input/11.txt').map do |line|
    line
      .scan(/(\w+) generator|(\w+)-compatible microchip/)
      .map { |gen, chip| gen ? Generator.new(gen.to_sym) : Microchip.new(chip.to_sym) }
  end
  Configuration.new(0, 0, floors)
end
