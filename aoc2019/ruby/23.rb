require 'set'
require_relative 'intcode'

N_COMPUTERS = 50

program = read_intcode('../input/input23.txt')

class NetworkInterfaceController
  attr_reader :part1, :part2, :nat

  def initialize
    @mutex = Mutex.new
    @channels = Hash.new { |h,k| h[k] = Queue.new << k << -1 }
    @part1 = Queue.new
    @part2 = Queue.new
    @nat = Queue.new
    @waiting = Set.new
  end

  def connect(id)
    @mutex.synchronize { Connection.new(self, @channels[id], id) }
  end

  def send(address, x, y)
    p [:send, address, x, y]
    @mutex.synchronize {
      if address === 255
        @nat = [x,y]
        p [:nat, @nat]
      else
        channel = @channels[address]
        channel << x
        channel << y
      end
    }
  end

  def idle?
    @mutex.synchronize { @channels.size == N_COMPUTERS && @channels.values.all? { |channel| channel.num_waiting > 0 } }
  end

  def nat
    @mutex.synchronize { @nat }
  end

end

class Connection
  def initialize(nic, input, id)
    @nic = nic
    @id = id
    @input = input
    @write_buffer = []
  end

  def shift
    @input.shift
  end

  def push(value)
    @write_buffer.push(value)

    if @write_buffer.length == 3
      p [:from, @id]
      @nic.send(*@write_buffer)
      @write_buffer.clear
    end
  end
end

nic = NetworkInterfaceController.new

puts "booting up..."
cpus = N_COMPUTERS.times.map do |i|
  t = Thread.new {
    connection = nic.connect(i)
    IntcodeComputer.new(
      program,
      input: connection,
      output: connection
    ).run
  }
  p [i, t]
  t
end

sleep until cpus.all? { |cpu| s = p cpu.status; s == 'sleep' || s == 'run' }
puts "waiting..."


prev_y = nil
loop do
  sleep 0.1 until nic.idle? && nic.nat
  p :IDLE
  x,y = p nic.nat
  if y == prev_y
    puts "JA: #{y}"
  end
  prev_y = y
  nic.send(0, x, y)
end
