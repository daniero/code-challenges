class Bot
  attr_accessor :input, :name

  def initialize(name)
    @name = name
    @input = []
  end

  def receives(value)
    @input << value

    check_receivers()
  end

  def gives_low(bot)
    @out_lo = bot
    check_receivers()
  end

  def gives_high(bot)
    @out_hi = bot
    check_receivers()
  end

  def check_receivers
    if @out_lo && @out_hi && @input.size == 2
      lo, hi = @input.minmax
      @out_lo.receives lo
      @out_hi.receives hi
    end
  end
end

VALUES = [17, 61]

bots = Hash.new { |hash, key| hash[key] = Bot.new(key) }
input = File.open('10_input.txt')

input.each_line do |line|
  case line
  when /(bot \d+) gives low to ((?:bot|output) \d+) and high to ((?:bot|output) \d+)/
    gives, to_low, to_high = bots.values_at($1, $2, $3)

    gives.gives_low(to_low)
    gives.gives_high(to_high)
  when /value (\d+) goes to (bot \d+)/
    value, bot = $1.to_i, bots[$2]

    bot.receives(value)
  else
    puts "huh?"
  end
end

puts bots.values.find { |bot| bot.input&.sort == VALUES }.name
