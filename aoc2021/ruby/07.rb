input = File.read('../input/07.txt').scan(/\d+/).map(&:to_i)
#input = [16,1,2,0,4,2,7,1,2,14]

p input
  .map { |n| input.sum { |m| (m-n).abs } }
  .min

p input.min.upto(input.max)
  .map { |n| input.sum { |m| (0..(m-n).abs).sum } }
  .min
