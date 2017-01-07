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
      when 0  # halt
        break
      when  1 # set: a b
        # TODO set register <a> to the value of <b>
      when  2 # push: a
        # TODO push <a> onto the stack
      when  3 # pop: a
        # TODO remove the top element from the stack and write it into <a>; empty stack = error
      when  4 # eq: a b c
        # TODO set <a> to 1 if <b> is equal to <c>; set it to 0 otherwise
      when  5 # gt: a b c
        # TODO set <a> to 1 if <b> is greater than <c>; set it to 0 otherwise
      when  6 # jmp: a
        # TODO jump to <a>
      when  7 # jt: a b
        # TODO if <a> is nonzero, jump to <b>
      when  8 # jf: a b
        # TODO if <a> is zero, jump to <b>
      when  9 # add: a b c
        # TODO assign into <a> the sum of <b> and <c> (modulo 32768)
      when 10 # mult: a b c
        # TODO store into <a> the product of <b> and <c> (modulo 32768)
      when 11 # mod: a b c
        # TODO store into <a> the remainder of <b> divided by <c>
      when 12 # and: a b c
        # TODO stores into <a> the bitwise and of <b> and <c>
      when 13 # or: a b c
        # TODO stores into <a> the bitwise or of <b> and <c>
      when 14 # not: a b
        # TODO stores 15-bit bitwise inverse of <b> in <a>
      when 15 # rmem: a b
        # TODO read memory at address <b> and write it to <a>
      when 16 # wmem: a b
        # TODO write the value from <b> into memory at address <a>
      when 17 # call: a
        # TODO write the address of the next instruction to the stack and jump to <a>
      when 18 # ret:
        # TODO remove the top element from the stack and jump to it; empty stack = halt
      when 19 # out: a
        # TODO write the character represented by ascii code <a> to the terminal
      when 20 # in: a
        # TODO read a character from the terminal and write its ascii code to <a>; it can be assumed that once input starts, it will continue until a newline is encountered; this means that you can safely read whole lines from the keyboard and trust that they will be fully read
      when 21 # noop
        # Do nothing
      end
    end
  end
end

program = tokenize(read('challenge.bin'))
vm = VirtualMachine.new(program)
vm.run
