DIGITS = [*1..9]
OPS = ["+", "-", ""]

puts OPS
  .repeated_permutation(DIGITS.size - 1)
  .map { |ops| DIGITS.zip(ops).join }
  .select { |s| eval(s) == 100 }
