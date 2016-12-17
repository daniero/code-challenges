require 'digest'

CODE = 'lpvhkcbi'

START = [0,0]
TARGET = [3,3]
DIRECTIONS = {"U" => [0, -1], "D" => [0, 1], "L" => [-1, 0], "R" => [1, 0]}

def search(start)
  queue = [[0, '', START]] # moves, path, coordinates

  Enumerator.new do |yielder|
    loop do
      state = queue.shift
      break unless state

      moves, path, (x,y) = state

      if [x,y] == TARGET
        yielder << state
        next
      end

      doors_open =
        Digest::MD5.hexdigest(CODE+path)
        .chars.take(4)
        .map { |c| c =~ /[b-f]/ }

      directions = DIRECTIONS.select.with_index { |_, i| doors_open[i] }

      directions.each do |direction, (i, j)|
        new_x, new_y = x + i, y + j
        next if new_x < 0 || new_x > 3 || new_y < 0 || new_y > 3

        queue << [moves + 1, path + direction, [new_x, new_y]]
      end
    end
  end
end

p search(START).peek
