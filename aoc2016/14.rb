require 'digest'

SALT = 'ahsbgdzn'

class String
  def triplet
    self[/(.)\1\1/]&.[](0)
  end

  def quintuplets
    self.scan(/(.)\1\1\1\1/).flat_map(&:first).uniq
  end
end

def keys(salt)
  triplets = Hash.new { |h,k| h[k] = [] }

  Enumerator.new do |yielder|
    0.step do |i|
      hash = Digest::MD5.hexdigest("#{salt}#{i}")
      next unless triplet = hash.triplet

      hash.quintuplets
        .flat_map { |char| triplets[char].select { |found_at| found_at > i - 1000 } }
        .sort
        .each { |key| yielder << key }

      triplets[triplet] << i
    end
  end
end

# Part 1:
puts keys(SALT).take(64).last


