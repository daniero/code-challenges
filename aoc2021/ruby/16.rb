require 'stringio'

def read_bits(input)
  input.chars.map { |c| c.to_i(16).to_s(2).rjust(4, '0') }.join
end

Packet = Struct.new(:version, :type, :value, :sub_packets, keyword_init: true)

def parse(bits)
  version = bits.read(3).to_i(2)
  type = bits.read(3).to_i(2)

  if type == 4
    buffer = ''
    loop do
      prefix = bits.read(1)
      buffer << bits.read(4)
      break if prefix == '0'
    end

    return Packet.new(version:version, type:type, value:buffer.to_i(2))
  end

  length_type = bits.read(1).to_i(2)

  if length_type == 0
    length = bits.read(15).to_i(2)
    stop = bits.pos + length

    sub_packets = []
    sub_packets << parse(bits) until bits.pos == stop
  else
    length = bits.read(11).to_i(2)
    sub_packets = length.times.map { parse(bits) }
  end

  return Packet.new(version:version, type:type, sub_packets:sub_packets)
end

def sum_version(packet)
  sub_packets = packet.sub_packets || []
  packet.version + sub_packets.sum { sum_version(_1) }
end

input = File.read('../input/16.txt').chomp
bits = StringIO.new(read_bits input)
packets = parse bits

puts "Part 1: #{sum_version packets}"

def calculate_value(packet)
  case packet.type
  when 0
    packet.sub_packets.sum(&method(:calculate_value))
  when 1
    packet.sub_packets.map(&method(:calculate_value)).reduce(:*)
  when 2
    packet.sub_packets.map(&method(:calculate_value)).min
  when 4
    packet.value
  when 3
    packet.sub_packets.map(&method(:calculate_value)).max
  when 5
    packet.sub_packets.map(&method(:calculate_value)).reduce(:>) ? 1 : 0
  when 6
    packet.sub_packets.map(&method(:calculate_value)).reduce(:<) ? 1 : 0
  when 7
    packet.sub_packets.map(&method(:calculate_value)).reduce(:==) ? 1 : 0
  end
end

puts "Part 2: #{calculate_value(packets)}"
