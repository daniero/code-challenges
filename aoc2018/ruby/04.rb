require 'date'

def minutes_asleep(changes)
  [0, *changes, 60]
    .each_cons(2)
    .with_index
    .flat_map { |(t1, t2), i| (t1...t2).map { i%2 } }
end

def sum_sleep_pr_minute_pr_guard(input)
  shifts = input
    .slice_before { |_, event| event =~ /begins shift/ }
    .map { |(_, start), *sleep_changes|
      guard_id = start[/(?<=Guard #)\d+/].to_i
      minutes = sleep_changes.map(&:first)
      [guard_id, minutes_asleep(minutes)]
    }

  guard_ids = shifts.map(&:first).uniq

  sum_sleep_pr_minute =
    guard_ids.map do |guard_id|
      shifts
        .select { |id, _| id == guard_id }
        .map(&:last)
        .transpose
        .map(&:sum)
    end

  return [guard_ids, sum_sleep_pr_minute].transpose.to_h
end


input = File.readlines('../input/input04.txt')
  .sort
  .flat_map { |line| line.scan /\[(.*)\] (.*)/  }
  .map { |timestamp, event| [DateTime.parse(timestamp).minute, event] }

sleep_pr_guard = sum_sleep_pr_minute_pr_guard(input)


# Part 1

id, sleep = sleep_pr_guard.max_by { |id, sleep| sleep.sum }
puts id * sleep.index(sleep.max)


# Part 2

max_value_index = sleep_pr_guard.values.flatten.each_with_index.max.last

max_minute = max_value_index % 60
id = sleep_pr_guard.keys[max_value_index / 60]

puts id * max_minute

