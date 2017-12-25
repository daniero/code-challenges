require 'set'

input = File.readlines('../input/input12.txt').map { |line| line.scan(/\d+/).map(&:to_i) }
programs = Hash.new { |h,k| Set[k] }

input.each { |ids|
  sets = programs.values_at(*ids)
  cluster = sets.reduce(Set.new) { |super_set, set| super_set.merge set }

  cluster.each { |id| programs[id] = cluster }
}

p programs[0].size
p programs.values.uniq.size
