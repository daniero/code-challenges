class TuringMachine
  attr_reader :checksum_steps, :tape

  def initialize()
    @tape = []
    @cursor = 0
  end

  def read
    @tape[@cursor] || 0
  end

  def write(value)
    @tape[@cursor] = value
  end

  def move_right
    @cursor+= 1
  end
  
  def move_left
    if @cursor > 0
      @cursor-= 1
    else
      @tape.unshift(0)
    end
  end

  def step
    @state = self.method(@state).call
  end
end

instructions = File.read('../input/input25.txt')
  .downcase
  .gsub(/begin in state (\w)./) { "@state = :#$1" }
  .gsub(/perform a diagnostic checksum after (\d+) steps.\n/) { "@checksum_steps = #$1" }
  .gsub(/in state (\w):/) { "def #$1" }
  .gsub(/if .* 0:/) { "if read == 0" }
  .gsub(/if .* 1:/) { "else" }
  .gsub(/- write the value (\d)./) { "write #$1" }
  .gsub(/- move one slot to the (\w+)./) { "move_#$1" }
  .gsub(/- continue with state (\w)./) { ":#$1" }
  .gsub(/^$|\z$/) { "  end\nend\n" }

tm = TuringMachine.new
tm.instance_eval instructions

tm.checksum_steps.times { tm.step }
p tm.tape.count(1)
