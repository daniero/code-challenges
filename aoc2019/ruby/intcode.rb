class IntcodeComputer
  attr_accessor :memory

  def initialize(program, noun = nil, verb = nil)
    @memory = program.dup
    memory[1] = noun || memory[1]
    memory[2] = verb || memory[2]
  end

  def run()
    memory.each_slice(4) { |opcode, n1, n2, target|
      case opcode
      when 1
        memory[target] = memory[n1] + memory[n2]
      when 2
        memory[target] = memory[n1] * memory[n2]
      when 99
        break
      end
    }

    return memory[0]
  end
end
