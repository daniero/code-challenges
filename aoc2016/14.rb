require 'digest'

SALT = 'ahsbgdzn'

class String
  def triplet
    self =~ /(.)\1\1/ && $1
  end

  def quintuplet
    self =~ /(.)\1\1\1\1/ && $1
  end
end

def keys(salt)
  triplets = Hash.new { |h,k| h[k] = [] }

  Enumerator.new do |yielder|
    0.step do |i|
      hash = yield("#{salt}#{i}")

      triplet = hash.triplet
      next unless triplet

      triplets[hash.quintuplet]
        .select { |found_at| found_at > i - 1000 }
        .each { |key| yielder << key }

      triplets[triplet] << i
    end
  end
end

# Part 1:
puts keys(SALT) { |s| Digest::MD5.hexdigest(s) }.take(64).last

# Part 2:
puts keys(SALT) { |s| (0..2016).reduce(s) { |h,_| Digest::MD5.hexdigest(h) } }.take(64).last
