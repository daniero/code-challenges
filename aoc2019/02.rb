input = File.read('input/input02.txt').scan(/\d+/).map(&:to_i)

input[1] = 12
input[2] = 2

input
  .each_slice(4) { |a,b,c,d|
    case a
    when 1
      input[d] = input[b] + input[c]
    when 2
      input[d] = input[b] * input[c]
    when 99
      break
    end
  }

p input[0]
