require "minitest/autorun"

def decompress string
  match = (string =~ /\((\d+)x(\d+)\)/)
  return string unless match

  chars, repeat = [$1, $2].map(&:to_i)
  sub = $'[0, chars]

  $` + sub * repeat + decompress($'[chars..-1])
end

describe '#decompress' do
  it "works" do
    assert_equal "ADVENT", decompress("ADVENT")
    assert_equal "ABBBBBC", decompress("A(1x5)BC")
    assert_equal "XYZXYZXYZ", decompress("(3x3)XYZ")
    assert_equal "ABCBCDEFEFG", decompress("A(2x2)BCD(2x2)EFG")
    assert_equal "(1x3)A", decompress("(6x1)(1x3)A")
    assert_equal "X(3x3)ABC(3x3)ABCY", decompress("X(8x2)(3x3)ABCY")
  end
end

x = decompress File.read('09_input.txt').strip
p x.size
