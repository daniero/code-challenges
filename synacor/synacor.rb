VALUE_LIMIT = 32768
VALUE_RANGE = (0...VALUE_LIMIT)
NUM_REGISTERS = 8
REGISTER_RANGE = (VALUE_LIMIT...VALUE_LIMIT+NUM_REGISTERS)

def read(filename)
  Enumerator.new do |yielder|
    File.open(filename) do |file|
      until file.eof?
        yielder << file.read(2).unpack('S<').first
      end
    end
  end
end

def debug(string)
  puts "\e[#{32}m#{string}\e[0m"
end

class VirtualMachine
  def initialize(program)
    @registers = Array.new(8) { 0 }
    @memory = program
    @stack = []
    @ip = 0
  end

  def read
    old_ip = @ip
    @ip += 1
    @memory[old_ip]
  end

  def get(value)
    case value
    when VALUE_RANGE
      value
    when REGISTER_RANGE
      r = value - VALUE_LIMIT
      @registers[r] || 0
    else
      raise "Invalid value: #{value}"
    end
  end

  def set(target, value)
    case target
    when REGISTER_RANGE
      reg = target - VALUE_LIMIT
      @registers[reg] = value
    else
      @memory[target] = value
    end
  end

  def run
    loop do
      code = read

      case code
      when 0  # halt
        break

      when  1 # set: a b
        a, b = read, get(read)
        set(a, b)

      when  2 # push: a
        @stack.push get(read)

      when  3 # pop: a
        raise "pop: Stack empty" if @stack.empty?
        set(read, @stack.pop)

      when  4 # eq: a b c
        a,b,c = read, get(read), get(read)
        set(a, b == c ? 1 : 0)

      when  5 # gt: a b c
        a,b,c = read, get(read), get(read)
        set(a, b > c ? 1 : 0)

      when  6 # jmp: a
        @ip = get(read)

      when  7 # jt: a b
        a, b = get(read), read
        @ip = b if a != 0

      when  8 # jf: a b
        a, b = get(read), read
        @ip = b if a == 0

      when  9 # add: a b c
        a,b,c = read, get(read), get(read)
        set(a, (b + c) % VALUE_LIMIT)

      when 10 # mult: a b c
        a,b,c = read, get(read), get(read)
        set(a, (b * c) % VALUE_LIMIT)

      when 11 # mod: a b c
        a,b,c = read, get(read), get(read)
        set(a, (b % c) % VALUE_LIMIT)

      when 12 # and: a b c
        a,b,c = read, get(read), get(read)
        set(a, b & c)

      when 13 # or: a b c
        a,b,c = read, get(read), get(read)
        set(a, b | c)

      when 14 # not: a b
        a,b = read, get(read)
        not_b = ~b & (VALUE_LIMIT - 1)
        set(a, not_b)

      when 15 # rmem: a b
        a = read
        r = get(read)
        b = @memory[r]
        set(a, b)

      when 16 # wmem: a b
        a,b = get(read), get(read)
        @memory[a] = b

      when 17 # call: a
        a = get(read)
        @stack.push(@ip)
        @ip = a

      when 18 # ret:
        break if @stack.empty?
        @ip = @stack.pop

      when 19 # out: a
        print get(read).chr

      when 20 # in: a
        a = read
        input = $<.getc
        break unless input
        set(a, input.ord)

      when 21 # noop
        # Do nothing
      else
        break
      end
    end
  end
end

program = read('challenge.bin')
vm = VirtualMachine.new(program.to_a)
vm.run
