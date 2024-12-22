def next_secret(s)
  s = s ^ (s * 64) % 16777216
  s = s ^ (s / 32) % 16777216
  s = s ^ (s * 2048) % 16777216 
end

input = File.readlines('../input/22-sample.txt').map(&:to_i)

p input.sum { |secret|
  2000.times { secret = next_secret(secret) }
  secret
}
