frequency_changes = File.readlines('../input/input01.txt').map(&:to_i)

# Part 1
p frequency_changes.sum

# Part 2
require 'set'
frequency = 0
frequenies = Set[frequency]

frequency_changes
  .cycle
  .each { |change|
    frequency += change
    unless frequenies.add? frequency
      p frequency
      break
    end
  }
