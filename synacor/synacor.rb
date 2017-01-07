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

def debug(string)
  puts "\e[#{32}m#{string}\e[0m"
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
    old_ip = @ip
    @ip += 1
    @program[old_ip]
  end

  def get(value)
    case value
    when Register
      @registers[value.address]
    else
      value
    end
  end

  def set(target, value)
    case target
    when Register
      @registers[target.address] = value
    else
      @memory[target] = value
    end
  end

  def run
    while @ip < @program.length
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
        set(a, (b + c) % 32768)

      when 10 # mult: a b c
        # TODO store into <a> the product of <b> and <c> (modulo 32768)
        debug :mult

      when 11 # mod: a b c
        # TODO store into <a> the remainder of <b> divided by <c>
        debug :mod

      when 12 # and: a b c
        a,b,c = read, get(read), get(read)
        set(a, b & c)

      when 13 # or: a b c
        a,b,c = read, get(read), get(read)
        set(a, b | c)

      when 14 # not: a b
        a,b = read, get(read)
        set(a, ~b & (2**15 - 1))

      when 15 # rmem: a b
        # TODO read memory at address <b> and write it to <a>
        debug :rmem

      when 16 # wmem: a b
        # TODO write the value from <b> into memory at address <a>
        debug :wmem

      when 17 # call: a
        a = get(read)
        @stack.push(@ip)
        @ip = a

      when 18 # ret:
        # TODO remove the top element from the stack and jump to it; empty stack = halt

      when 19 # out: a
        print get(read).chr

      when 20 # in: a
        # TODO read a character from the terminal and write its ascii code to <a>; it can be assumed that once input starts, it will continue until a newline is encountered; this means that you can safely read whole lines from the keyboard and trust that they will be fully read
        debug :in

      when 21 # noop
        # Do nothing
      else
        debug "Unknown op code: #{code}"
      end
    end
  end
end

program = tokenize(read('challenge.bin'))
vm = VirtualMachine.new(program)
vm.run
