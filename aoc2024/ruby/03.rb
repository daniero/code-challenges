input = File.read('../input/03-sample.txt')

# Part 1
p input.scan(/mul\((\d+),(\d+)\)/).sum { |a,b| a.to_i * b.to_i }


# Part 2
sum = 0
enabled = true

input.scan(/do(n't)?\(\)|mul\((\d+),(\d+)\)/) do
  if $& == "do()"
    enabled = true
  elsif $& == "don't()"
    enabled = false
  elsif enabled
    sum+= $2.to_i * $3.to_i
  end
end

p sum
