PositionMode = 0
ImmediateMode = 1
RelativeMode = 2

class IntcodeComputer
  attr_accessor :memory, :ip, :relative_base, :input, :output

  def initialize(program,
                 input: [],
                 output: []
                )
    @memory = program.dup
    @input = input
    @output = output
    @ip = 0
    @relative_base = 0
    @status = 'ok'
  end

  def apply(&block)
    instance_eval(&block)
    self
  end

  def read_int
    memory[ip]
      .tap { @ip += 1 }
  end

  def read_instruction
    opcode = read_int

    instruction = opcode % 100
    m1 = opcode / 100 % 10
    m2 = opcode / 1000 % 10
    m3 = opcode / 10000 % 10

    [instruction, m1, m2, m3]
  end

  def read_value(mode)
    value = read_int
    if mode == PositionMode
      return memory[value] || 0
    elsif mode == RelativeMode
      return memory[value + relative_base] || 0
    else
      return value
    end
  end

  def write_value(value, mode)
    target = read_int

    if (mode == PositionMode)
      memory[target] = value
    elsif (mode == RelativeMode)
      memory[target + relative_base] = value
    else
      raise "Illegal write mode"
    end
  end

  def run()
    while ip < memory.length
      instruction, m1, m2, m3 = read_instruction

      case instruction
      when 1
        a = read_value(m1)
        b = read_value(m2)
        write_value(a + b, m3)
      when 2
        a = read_value(m1)
        b = read_value(m2)
        write_value(a * b, m3)
      when 3
        a = input.shift
        write_value(a, m1)
      when 4
        a = read_value(m1)
        @output = output.push(a)
      when 5
        a = read_value(m1)
        b = read_value(m2)
        @ip = b if a.nonzero?
      when 6
        a = read_value(m1)
        b = read_value(m2)
        @ip = b if a.zero?
      when 7
        a = read_value(m1)
        b = read_value(m2)
        write_value(a < b ? 1 : 0, m3)
      when 8
        a = read_value(m1)
        b = read_value(m2)
        write_value(a == b ? 1 : 0, m3)
      when 9
        a = read_value(m1)
        @relative_base += a
      when 99
        break
      else
        $stderr.puts "Unknown instruction: #{instruction}"
      end
    end

    return self
  rescue StopIteration
    @status = 'break'
    return self
  end
end

def read_intcode(filename)
  File.read(ARGV[0] || filename).scan(/-?\d+/).map(&:to_i)
end
