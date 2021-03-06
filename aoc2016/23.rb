def run(cmds, ip, reg)
  cmd = cmds[ip % cmds.size]

  case cmd
  when /cpy ([a-z]) (\w)/
    val, dst = $1, $2
    reg[dst] = reg[val]

  when /cpy (-?[0-9]+) (\w)/
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

  when /jnz (\d+) ([a-z])/
    val, dst = $1.to_i, reg[$2]
    return ip + (val == 0 ? 1 : dst)

  when /tgl ([a-z])/
    dst = reg[$1] + ip
    toggle(cmds, dst)

  when /tgl (-?\d+)/
    dst = $1.to_i + ip
    toggle(cmds, dst)
  end
  ip + 1
end

def toggle(cmds, dst)
  if dst >= 0 && dst < cmds.size
    subs = {"inc" => "dec",
            "dec" => "inc",
            "tgl" => "inc",
            "jnz" => "cpy",
            "cpy" => "jnz"}
    from,to = subs.find { |cmd,_| cmds[dst].start_with? cmd }
    cmds[dst].sub!(from, to)
  end
end

# Part 1

cmds = File.read('input/23.txt').lines
reg = {"a"=>7, "b"=>0, "c"=>0, "d"=>0}
ip = 0

while ip < cmds.size
  ip = run(cmds, ip, reg)
end

puts reg["a"]

# Part 2

cmds = File.read('input/23.txt').lines
reg = {"a"=>12, "b"=>0, "c"=>0, "d"=>0}
ip = 0

while ip < cmds.size
  ip = run(cmds, ip, reg)
end

puts reg["a"]
