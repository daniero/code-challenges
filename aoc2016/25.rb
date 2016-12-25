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

  when /out ([a-z])/
    val = reg[$1]
    yield val
  end
  ip + 1
end

def brute(cmds)
  infinite = 8  # Sufficiently infinite ?

  0.step do |a|
    catch :nope do
      reg = {"a"=>a, "b"=>0, "c"=>0, "d"=>0}
      ip = 0

      i = 0
      loop do
        ip = run(cmds, ip, reg) { |x|
          throw :nope if x != i%2
          i+=1
          return a if i == infinite
        }
      end
    end
  end
end

cmds = File.read('input/25.txt').lines

p brute(cmds)
