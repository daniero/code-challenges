initial_layer = File
  .readlines(ARGV[0] || '../input/17.txt')
  .each_with_index.map { |row, y|
  cols = row
    .chomp
    .chars
    .each_with_index.map { |c,x| c == '#' ? [x,true] : nil }
    .compact
    .to_h
  [y, cols]
}
  .to_h

def neighbours(x,y,z)
  [x-1, x, x+1].product([y-1, y, y+1], [z-1, z, z+1]) - [[x,y,z]]
end

z_min, z_max = 0, 0
y_min, y_max = initial_layer.keys.minmax
x_min, x_max = initial_layer.values.map(&:keys).flatten.minmax

state = { 0 => initial_layer }

6.times do
  z_min -= 1; y_min -= 1; x_min -= 1
  z_max += 1; y_max += 1; x_max += 1

  next_state = Hash.new { |h,z| h[z] = Hash.new { |g,y| g[y] = Hash.new } }

  (z_min..z_max).map do |z|
    (y_min..y_max).map do |y|
      (x_min..x_max).map do |x|
        cell = state.dig(z,y,x)
        n = neighbours(x,y,z).count { |i,j,k| state.dig(k,j,i) }
        if n == 3 || cell && n == 2
          next_state[z][y][x] = true
        end
      end
    end
  end

  state = next_state
end

p state.sum { |_,layer| layer.sum { |_,row| row.count } }
