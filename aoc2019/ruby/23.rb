require_relative 'intcode'

N_COMPUTERS = 50

program = read_intcode('../input/input23.txt')

class NetworkInterfaceController
  attr_reader :nat

  def initialize
    @mutex = Mutex.new
    @channels = Hash.new { |h,k| h[k] = [k] }
    @nat = @channels[255] = Queue.new
  end

  def connect(id)
    @mutex.synchronize { Connection.new(self, id) }
  end

  def send(address, x, y)
    @mutex.synchronize {
      channel = @channels[address]
      channel.push(x)
      channel.push(y)
    }
  end

  def receive(id)
    @mutex.synchronize {
      channel = @channels[id]
      channel.empty? ? -1 : channel.shift
    }
  end
end

class Connection
  def initialize(nic, id)
    @nic = nic
    @id = id
    @write_buffer = []
  end

  def shift
    @nic.receive(@id)
  end

  def push(value)
    @write_buffer.push(value)

    if @write_buffer.length == 3
      @nic.send(*@write_buffer)
      @write_buffer.clear
    end
  end
end

nic = NetworkInterfaceController.new

N_COMPUTERS.times do |i|
  Thread.new {
    connection = nic.connect(i)
    IntcodeComputer.new(
      program,
      input: connection,
      output: connection
    ).run
  }
end

nic.nat.shift
p nic.nat.shift
