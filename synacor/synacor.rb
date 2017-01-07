def read(filename)
  Enumerator.new do |yielder|
    File.open(filename) do |file|
      until file.eof?
        yielder << file.read(2).unpack('S<').first
      end
    end
  end
end

Register = Struct.new(:address)

def tokenize(input)
  input.map { |x|
    case x
    when 0..32767
      x
    when 32768..32775
      Register.new(x - 32768)
    else
      raise "Invalid input"
    end
  }
end

class VirtualMachine
  def initialize(program)
    @registers = Array.new(8) { 0 }
    @memory = {}
    @stack = []

    @program = program
    @ip = 0
  end

  def read
    @program[@ip += 1]
  end

  def run
    while @ip < @program.length
      case read
      when 21
        # Noop
      end
    end
  end
end

program = tokenize(read('challenge.bin'))
vm = VirtualMachine.new(program)
vm.run
