x, y = 0, 0
direction = 0
visited = {}
revisit = false

make_path = ->(xs, ys) { [*xs].product([*ys]) }

DIRECTIONS = [
  ->(distance) { make_path[x, y.upto(y+distance)] },   # up
  ->(distance) { make_path[x.upto(x+distance), y] },   # left
  ->(distance) { make_path[x, y.downto(y-distance)] }, # down
  ->(distance) { make_path[x.downto(x-distance), y] }  # right
]

steps = File.read("01_input.txt").scan(/(\w)(\d+)/).map { |turn, distance| ["LxR".index(turn)-1, distance.to_i] }

steps.each do |turn, distance|
  direction += turn
  go = DIRECTIONS[direction % 4]

  path = go[distance]

  path.each do |new_pos|
    if visited[new_pos] && !revisit
      puts "Already visited #{new_pos}. Distance: #{new_pos[0].abs + new_pos[1].abs}"
      revisit = true
    end

    visited[[x,y]] = true
    x, y = new_pos
  end

end

puts "Stopped at #{[x,y]}. Final distance: #{x.abs + y.abs}"
