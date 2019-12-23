require_relative 'intcode'

N_COMPUTERS = 50

program = read_intcode('../input/input23.txt')

class NetworkInterfaceController
  attr_reader :part1

  def initialize
    @mutex = Mutex.new
    @channels = Hash.new { |h,k| h[k] = Channel[k] }
    @part1 = Queue.new
  end

  def connect(id)
    @mutex.synchronize { @channels[id] }
  end

  def push(address)
    @mutex.synchronize {
      if address < N_COMPUTERS
        Connection.new(self, @channels[address])
      elsif address == 255
        @part1
      end
    }
  end
end

class Channel
  def initialize(id)
    @mutex = Mutex.new
    @channel = Queue.new << id
  end

  def lock
    @mutex.lock
    true
  end

  def unlock
    @mutex.unlock
    true
  end

  def push(value)
    @channel.push(value)
  end

  def shift
    @channel.empty? ? -1 : @channel.shift
  end
end

class Connection
  def initialize(nic, channel)
    channel.lock
    @channel = channel
    @nic = nic
    @send_count = 0
  end

  def push(value)
    @channel.push(value)
    @send_count += 1

    if @send_count == 2
      @channel.unlock
      return @nic
    else
      return self
    end
  end
end

nic = NetworkInterfaceController.new

N_COMPUTERS.times do |i|
  Thread.new {
    IntcodeComputer.new(
      program,
      input: nic.connect(i),
      output: nic
    ).run
  }
end

q = nic.part1
q.shift
p q.shift
