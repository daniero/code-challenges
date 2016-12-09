require "minitest/autorun"

def decompressed_size(string)
  match = (string =~ /\((\d+)x(\d+)\)/)
  return string.size unless match

  chars, repeat = [$1, $2].map(&:to_i)

  $`.size + (chars * repeat) + decompressed_size($'[chars..-1])
end

describe '#decompressed_size' do
  it "works" do
    assert_equal "ADVENT".size, decompressed_size("ADVENT")
    assert_equal "ABBBBBC".size, decompressed_size("A(1x5)BC")
    assert_equal "XYZXYZXYZ".size, decompressed_size("(3x3)XYZ")
    assert_equal "ABCBCDEFEFG".size, decompressed_size("A(2x2)BCD(2x2)EFG")
    assert_equal "(1x3)A".size, decompressed_size("(6x1)(1x3)A")
    assert_equal "X(3x3)ABC(3x3)ABCY".size, decompressed_size("X(8x2)(3x3)ABCY")
  end
end

p decompressed_size(File.read('09_input.txt').strip)
