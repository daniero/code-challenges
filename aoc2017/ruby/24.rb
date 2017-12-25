Bridge = Struct.new(:length, :strength, :out, :remaining_components) do
  def connect(component)
    new_out = if component.first == out then component.last else component.first end
    new_strength = strength + component.sum
    remains = remaining_components - [component]

    Bridge.new(length + 1, new_strength, new_out, remains)
  end

  def continuations
    remaining_components
      .select { |a,b| a == out || b == out }
      .map { |c| connect(c) }
  end
end

components =
  File.read('../input/input24.txt')
  .scan(/(\d+)\/(\d+)/)
  .map { |i,o| [i.to_i, o.to_i] }

bridges = Bridge.new(0, 0, 0, components).continuations
strongest = longest = bridges.first

until bridges.empty?
  next_batch = []

  bridges.each do |bridge|
    continuations = bridge.continuations

    if continuations.empty?
      strongest = [strongest, bridge].max_by { |b| b.strength }
      longest = [longest, bridge].max_by { |b| [b.length, b.strength] }
    else
      next_batch+= continuations
    end
  end

  bridges = next_batch
end

puts strongest.strength
puts longest.strength
