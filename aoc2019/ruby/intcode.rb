PositionMode = 0
ImmediateMode = 1

class IntcodeComputer
  attr_accessor :memory, :ip

  def initialize(program,
                 noun: nil,
                 verb: nil)
    @memory = program.dup
    memory[1] = noun || memory[1]
    memory[2] = verb || memory[2]
    @ip = 0
  end

  def read_int
    memory[ip]
      .tap { @ip += 1 }
  end

  def read_instruction
    opcode = read_int
    e,d,c,b,a = opcode.digits

    instruction = 10 * (d||0) + e
    m1 = c || PositionMode
    m2 = b || PositionMode
    m3 = a || PositionMode

    [instruction, m1, m2, m3]
  end

  def read_value(mode)
    value = read_int
    if mode == PositionMode
      return memory[value]
    else
      return value
    end
  end

  def write_value(value)
    target = read_value(ImmediateMode)
    memory[target] = value
  end

  def run()
    while ip < memory.length
      instruction, m1, m2, m3 = read_instruction

      case instruction
      when 1
        a = read_value(m1)
        b = read_value(m2)
        write_value(a + b)
      when 2
        a = read_value(m1)
        b = read_value(m2)
        write_value(a * b)
      when 99
        break
      end
    end

    return memory[0]
  end
end
