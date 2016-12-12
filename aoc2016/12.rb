reg = {"a"=>0, "b"=>0, "c"=>0, "d"=>0}
ip = 0

cmds = File.open('input/12.txt').map do |line|
  case line
  when /cpy ([a-z]) (\w)/
    val, dst = $1, $2
    ->() {reg[dst] = reg[val]; ip+=1}
  when /cpy ([0-9]+) (\w)/
    val, dst = $1.to_i, $2
    ->() {reg[dst] = val; ip+=1}
  when /inc (\w)/
    dst = $1
    ->() {reg[dst] +=1; ip+=1}
  when /dec (\w)/
    dst = $1
    ->() {reg[dst] -=1; ip+=1}
  when /jnz ([a-z]) (-?\d+)/
    val, dst = $1, $2.to_i
    ->() {ip += (reg[val] == 0 ? 1 : dst)}
  when /jnz (\d+) (-?\d+)/
    val, dst = $1.to_i, $2.to_i
    ->() {ip += (val == 0 ? 1 : dst)}
  end
end


# Part 1

while ip < cmds.size
  cmds[ip%cmds.size].call()
end

p reg

# Part 2

reg = {"a"=>0, "b"=>0, "c"=>1, "d"=>0}
ip = 0

while ip < cmds.size
  cmds[ip%cmds.size].call()
end


p reg
