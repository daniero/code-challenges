input = File
  .readlines('../input/10.txt')
  .map(&:to_i)


jumps = [0, *input, input.max+3]
  .sort
  .each_cons(2)
  .map { |a,b| b-a }
  .tally
  
p jumps[1] * jumps[3]

