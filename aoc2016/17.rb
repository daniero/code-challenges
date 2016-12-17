require 'digest'

CODE = 'lpvhkcbi'

START = [0,0]
TARGET = [3,3]
DIRECTIONS = {"U" => [0, -1], "D" => [0, 1], "L" => [-1, 0], "R" => [1, 0]}

def search(start)
  queue = [['', START]]

  loop do
    state = queue.shift
    return nil unless state

    path, (x,y) = state
    return state if [x,y] == TARGET

    doors_open =
      Digest::MD5.hexdigest(CODE+path)
      .chars.take(4)
      .map { |c| c =~ /[b-f]/ }

    directions = DIRECTIONS.select.with_index { |_, i| doors_open[i] }

    directions.each do |direction, (i, j)|
      new_x, new_y = x + i, y + j
      next if new_x < 0 || new_x > 3 || new_y < 0 || new_y > 3

      new_path = path + direction

      queue << [new_path, [new_x, new_y]]
    end
  end
end

p search(START)

