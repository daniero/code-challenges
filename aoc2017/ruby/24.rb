Bridge = Struct.new(:strength, :out, :components_left) do
  def connect(component)
    new_out = if component.first == out then component.last else component.first end
    new_strength = strength + component.sum
    remains = components_left - [component]

    Bridge.new(new_strength, new_out, remains)
  end

  def continuations
    components_left
      .select { |a,b| a == out || b == out }
      .map { |c| connect(c) }
  end
end

components =
  File.read('../input24.txt')
  .scan(/(\d+)\/(\d+)/)
  .map { |i,o| [i.to_i, o.to_i] }

bridges = Bridge.new(0, 0, components).continuations
max_strenght = 0

until bridges.empty?
  next_bridges = []

  bridges.each do |bridge|
    continuations = bridge.continuations

    if continuations.empty?
      max_strenght = [max_strenght, bridge.strength].max
    else
      next_bridges+= continuations
    end
  end

  bridges = next_bridges
end

puts max_strenght
