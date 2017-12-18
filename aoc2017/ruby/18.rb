input = File.readlines('../input18.txt')
#input = DATA.readlines # Test data

def debug s
  # p s
end

# Part 1

commands = input.map { |line|
  case line
  when /snd (.)/
    reg = $1
    ->(regs) { regs[:rcv] = regs[reg]; 1 }
  when /set (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->(regs) { regs[reg] = val; 1 }
  when /set (.) (\w)/
    regA = $1
    regB = $2
    ->(regs) { regs[regA] = regs[regB]; 1 }
  when /add (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->(regs) { regs[reg]+= val; 1 }
  when /add (.) (.)/
    regA = $1
    regB = $2
    ->(regs) { regs[regA]+= regs[regB]; 1 }
  when /mul (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->(regs) { regs[reg]*= val; 1 }
  when /mul (.) (.)/
    regA = $1
    regB = $2
    ->(regs) { regs[regA]*= regs[regB]; 1 }
  when /mod (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->(regs) { regs[reg]%= val; 1 }
  when /mod (.) (.)/
    regA = $1
    regB = $2
    ->(regs) { regs[regA]%= regs[regB]; 1 }
  when /rcv (.)/
    reg = $1
    ->(regs) { raise "#{regs[:rcv]}" if regs[reg] > 0; 1 }
  when /jgz (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->(regs) { regs[reg] > 0 ? val : 1 }
  when /jgz (.) (.)/
    regA = $1
    regB = $2
    ->(regs) { regs[regA] > 0 ? regs[regB] : 1 }
  else
    raise "Unexpected: " + line
  end
}

begin
  regs = Hash.new{0}
  ip = 0
  loop do
    ip += commands[ip][regs]
  end
rescue => e
  puts e.message
end

__END__
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
