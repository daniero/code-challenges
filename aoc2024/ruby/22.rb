require 'set'

def next_secret(s)
  s = s ^ (s * 64) % 16777216
  s = s ^ (s / 32) % 16777216
  s = s ^ (s * 2048) % 16777216 
end

input = File.readlines('../input/22-sample.txt').map(&:to_i)


# Part 1

p input.sum { |secret|
  2000.times { secret = next_secret(secret) }
  secret
}


# Part 2

def prices(s, n=2000)
  seq = [s%10]
  (n-1).times { 
    s = next_secret(s)
    seq << s%10
  }
  seq
end

def changes(seq)
  seq.take(1) + seq.each_cons(2).map { _2 - _1 }
end

sum_changes = Hash.new { 0 }

input.each do |secret|
  seq = prices(secret)
  visited = Set[]

  changes(seq)
    .each_cons(4)
    .zip(seq.drop(3))
    .each do |change,price|
      sum_changes[change] += price if visited.add?(change)
    end
end

p sum_changes.values.max

