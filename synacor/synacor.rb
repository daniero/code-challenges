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

p *tokenize(read('challenge.bin').take(1000))
