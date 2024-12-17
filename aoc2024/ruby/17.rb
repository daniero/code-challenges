a,b,c, *program = File.read('../input/17.txt').scan(/\d+/).map(&:to_i)
ip = 0

out = []

while 0 <= ip && ip < program.length
  inst = program[ip]
  op = program[ip+1]

  val =
    case op
    when 0..3; op
    when 4; a
    when 5; b
    when 6; c
    else; raise "nope"
    end

  case inst
  when 0 # adv
    a = a/2**val
  when 1 # bxl
    b ^= op
  when 2 # bst
    b = val%8
  when 3 # jnz
    if a != 0
      ip = op
      next
    end
  when 4 # bxc
    b ^= c
  when 5 # out
    out << val%8
  when 6 # bdv
    b = a/2**val
  when 7 # cdv
    c = a/2**val
  end

  ip += 2
end

puts out.join(',')
