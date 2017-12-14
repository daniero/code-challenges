require_relative '10'

def hex2bin(s)
  '%0128b' % s.to_i(16)
end

INPUT = 'uugsqrei'

p (0..127).map { |i| hex2bin(knot_hash("#{INPUT}-#{i}")).count('1') }.reduce(:+)
