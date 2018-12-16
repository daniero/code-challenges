Step = Struct.new(:name, :complete, :dependencies)

def read_steps(filename)
  steps = Hash.new { |h,k| h[k] = Step.new(k, false, []) }

  File
    .open(filename)
    .each_line do |line|
      a, b = line.scan(/(?<=step )[A-Z]/i)
      steps[b].dependencies << steps[a]
    end

  steps.values
end

Worker = Struct.new(:working_on, :time)

def construct(steps, n_workers, extra_time)
  workers = Array.new(n_workers) { Worker.new(nil, 0) }

  queue = steps.dup
  completed_steps = ''

  0.step do |time|
    workers.each do |worker|
      worker.time -= 1

      if worker.time == 0
        completed_steps << worker.working_on.name
        worker.working_on.complete = true
        worker.working_on = nil
      end
    end

    workers.reject(&:working_on).sort_by(&:time).each do |worker|
      available_task = queue
          .select { |step| step.dependencies.all? &:complete }
          .min_by(&:name)

      if available_task
        worker.working_on = available_task
        worker.time = available_task.name.ord - 'A'.ord + 1 + extra_time
        queue.delete(available_task)
      end
    end

    in_progress = steps.size - completed_steps.size
    print "\r" +
      "[#{'%4s' % time}] || " +
      "[#{completed_steps}#{queue.map(&:name).join.rjust(in_progress, '·')}] || " +
      "[ " + workers.map { |w|
        step = w.working_on;
        step ? "#{step.name}#{'%3s' % w.time}" : ' ' * 4
      }.join(' | ') + " ]          "
    delay = 0.0008 * (steps.size-completed_steps.length)
    sleep delay

    break if steps.all? &:complete
  end
  puts
end


puts
puts

construct(read_steps('../input/input07.txt'), 1, 0) # Part 1
puts
construct(read_steps('../input/input07.txt'), 5, 60) # Part 2

puts
puts
