def run(cmds, ip, reg)
  case cmds[ip%cmds.size]
  when /cpy ([a-z]) (\w)/
    val, dst = $1, $2
    reg[dst] = reg[val]

  when /cpy ([0-9]+) (\w)/
    val, dst = $1.to_i, $2
    reg[dst] = val

  when /inc (\w)/
    dst = $1
    reg[dst] +=1

  when /dec (\w)/
    dst = $1
    reg[dst] -=1

  when /jnz ([a-z]) (-?\d+)/
    val, dst = $1, $2.to_i
    return ip + (reg[val] == 0 ? 1 : dst)

  when /jnz (\d+) (-?\d+)/
    val, dst = $1.to_i, $2.to_i
    return ip + (val == 0 ? 1 : dst)
  end
  ip + 1
end

cmds = File.read('input/12.txt').lines
reg = {"a"=>0, "b"=>0, "c"=>0, "d"=>0}
ip = 0

while ip < cmds.size
  ip = run(cmds, ip, reg)
end

puts reg["a"]
