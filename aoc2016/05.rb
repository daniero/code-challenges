require 'digest'
md5 = Digest::MD5

input = "wtnhxymk"
iterations = 8

pass = []

n = i = 0

while n < iterations
  hash = md5.hexdigest "#{input}#{i}"

  if hash.start_with? '00000'
    pass << hash[5]
    n += 1
  end

  i+= 1
end

puts pass.join
