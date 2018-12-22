DEPTH = 10647
TARGET = [7, 770].freeze

area = Array.new(TARGET[1] + 1) { Array.new(TARGET[0] + 1) }

area.map!.with_index do |row, y|
  row.map!.with_index do |region, x|
    geologic_index =
      if [x,y] == [0,0] || [x,y] == TARGET
        0
      elsif y == 0
        x * 16807
      elsif x == 0
        y * 48271
      else
        area[y-1][x] * area[y][x-1]
      end

    erosion_level = (geologic_index + DEPTH) % 20183
  end
end

p area.sum { |row| row.sum { |region| region % 3 } }
