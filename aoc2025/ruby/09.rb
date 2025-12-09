sample = false

if sample
  input_file = '../input-sample09.txt'
else
  input_file = '../input-real09.txt'
end


input = File
  .readlines(input_file)
  .map { it.scan(/\d+/).map(&:to_i) }

p input.combination(2).map { |(ax,ay),(bx,by)|
  -~(ax-bx).abs * -~(ay-by).abs
}.max
