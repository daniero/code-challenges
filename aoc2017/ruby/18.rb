input = File.readlines('../input/input18.txt')
#input = DATA.readlines # Test data

# Part 1

class Vm
  attr_reader :regs

  def initialize
    @regs = Hash.new{0}
    @ip = 0
  end

  def snd(val)
    @val = val
  end

  def rcv(reg)
    raise "#@val" if regs[reg] > 0
  end

  def step(program)
    @ip += instance_eval(&program[@ip])
  end

  def run(program)
    loop { step(program) }
  rescue => e
    puts e.message
  end
end

commands = input.map { |line|
  case line
  when /snd (.)/
    reg = $1
    ->() { snd(regs[reg]); 1 }
  when /set (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->() { regs[reg] = val; 1 }
  when /set (.) (\w)/
    regA = $1
    regB = $2
    ->() { regs[regA] = regs[regB]; 1 }
  when /add (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->() { regs[reg]+= val; 1 }
  when /add (.) (.)/
    regA = $1
    regB = $2
    ->() { regs[regA]+= regs[regB]; 1 }
  when /mul (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->() { regs[reg]*= val; 1 }
  when /mul (.) (.)/
    regA = $1
    regB = $2
    ->() { regs[regA]*= regs[regB]; 1 }
  when /mod (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->() { regs[reg]%= val; 1 }
  when /mod (.) (.)/
    regA = $1
    regB = $2
    ->() { regs[regA]%= regs[regB]; 1 }
  when /rcv (.)/
    reg = $1
    ->() { rcv(reg); 1 }
  when /jgz (.) (-?\d+)/
    reg = $1
    val = $2.to_i
    ->() { regs[reg] > 0 ? val : 1 }
  when /jgz (.) (.)/
    regA = $1
    regB = $2
    ->() { regs[regA] > 0 ? regs[regB] : 1 }
  else
    raise "Unexpected: " + line
  end
}

Vm.new.run(commands)

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
