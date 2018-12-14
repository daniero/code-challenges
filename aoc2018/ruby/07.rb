require 'set'

Step = Struct.new(:name, :complete, :dependencies)

steps = Hash.new { |h,k| h[k] = Step.new(k, false, []) }

File
  .open('../input/input07.txt')
  .each_line do |line|
    a, b = line.scan(/(?<=step )[A-Z]/i)
    steps[b].dependencies << steps[a]
  end

list = steps.values

until list.empty?
  next_step = list
    .select { |step| step.dependencies.all? &:complete }
    .min_by { |step| step.name }

  next_step.complete = true
  list.delete next_step

  print next_step.name
end
puts

