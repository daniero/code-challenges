require 'stringio'

def read_bits(input)
  input.chars.map { |c| c.to_i(16).to_s(2).rjust(4, '0') }.join
end

Packet = Struct.new(:version, :type, :data, :sub_packets, keyword_init: true)

def parse(bits)
  version = bits.read(3).to_i(2)
  type = bits.read(3).to_i(2)

  if type == 4
    data = ''
    loop do
      prefix = bits.read(1)
      data += bits.read(4)
      break if prefix == '0'
    end

    return Packet.new(version:version, type:type, data:data)
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

def part1(input)
  bits = StringIO.new(read_bits input)
  packets = parse bits
  sum_version packets
end

input = File.read('../input/16.txt').chomp

# pp part1(read_bits("D2FE28"))
# pp part1(read_bits("38006F45291200"))
# pp part1(read_bits("8A004A801A8002F478"))
# pp part1(read_bits("620080001611562C8802118E34"))
# pp part1(read_bits("EE00D40C823060"))
# puts
# pp part1(read_bits("8A004A801A8002F478"))
# pp part1(read_bits("620080001611562C8802118E34"))
# pp part1(read_bits("C0015000016115A2E0802F182340"))
# pp part1(read_bits("A0016C880162017C3686B18A3D4780"))

puts part1(input)
