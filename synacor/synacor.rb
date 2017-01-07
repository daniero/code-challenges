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

  def get(value)
    case value
    when Register
      @registers[value.address]
    else
      value
    end
  end

  def run
    while @ip < @program.length
      code = read
      case code
      when 0  # halt
        break
      when  1 # set: a b
        # TODO set register <a> to the value of <b>
        p :set
      when  2 # push: a
        # TODO push <a> onto the stack
        p :push
      when  3 # pop: a
        # TODO remove the top element from the stack and write it into <a>; empty stack = error
        p :pop
      when  4 # eq: a b c
        # TODO set <a> to 1 if <b> is equal to <c>; set it to 0 otherwise
        p :eq
      when  5 # gt: a b c
        # TODO set <a> to 1 if <b> is greater than <c>; set it to 0 otherwise
      when  6 # jmp: a
        @ip = get(read) - 1
      when  7 # jt: a b
        a, b = get(read), (read - 1)
        @ip = b if a != 0
      when  8 # jf: a b
        a, b = get(read), (read - 1)
        @ip = b if a == 0
      when  9 # add: a b c
        # TODO assign into <a> the sum of <b> and <c> (modulo 32768)
        p :add
      when 10 # mult: a b c
        # TODO store into <a> the product of <b> and <c> (modulo 32768)
        p :mult
      when 11 # mod: a b c
        # TODO store into <a> the remainder of <b> divided by <c>
        p :mod
      when 12 # and: a b c
        # TODO stores into <a> the bitwise and of <b> and <c>
        p :and
      when 13 # or: a b c
        # TODO stores into <a> the bitwise or of <b> and <c>
        p :or
      when 14 # not: a b
        # TODO stores 15-bit bitwise inverse of <b> in <a>
        p :not
      when 15 # rmem: a b
        # TODO read memory at address <b> and write it to <a>
        p :rmem
      when 16 # wmem: a b
        # TODO write the value from <b> into memory at address <a>
        p :wmem
      when 17 # call: a
        # TODO write the address of the next instruction to the stack and jump to <a>
        p :call
      when 18 # ret:
        # TODO remove the top element from the stack and jump to it; empty stack = halt
      when 19 # out: a
        print get(read).chr
      when 20 # in: a
        # TODO read a character from the terminal and write its ascii code to <a>; it can be assumed that once input starts, it will continue until a newline is encountered; this means that you can safely read whole lines from the keyboard and trust that they will be fully read
        p :in
      when 21 # noop
        # Do nothing
      else
        puts "Unknown op code: #{code}"
      end
    end
  end
end

program = tokenize(read('challenge.bin'))
vm = VirtualMachine.new(program)
vm.run
