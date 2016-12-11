Generator = Struct.new(:isotope, :shielded?)
Microchip = Struct.new(:isotope) do
  def safe?(generators)
    generators.empty? || generators.any? { |g| g.isotope == isotope }
  end
end


def done?(configuration)
  configuration[0..2].all?(&:empty?)
end

def ok?(configuration)
  configuration.all? do |floor|
    generators, microchips = floor.partition { |component| component.is_a? Generator }

    microchips.all? { |chip| chip.safe?(generators) }
  end
end

start_configuration = File.open('input/11.txt').map { |line|
  line.scan(/(\w+) generator|(\w+)-compatible microchip/).map { |gen, chip|
    gen ? Generator.new(gen.to_sym) : Microchip.new(chip.to_sym)
  }
}

require "pp"
pp start_configuration


pp ok? start_configuration
