WIDTH, HEIGHT = 50, 6

def draw_rectangle!(screen, width, height)
  pixles = [*0...width].product([*0...height])
  pixles.each { |x,y| screen[y][x] = 1 }
end

def rotate_row!(screen, index, amount)
  screen[index].rotate!(-amount)
end

def rotate_column!(screen, index, amount)
  column = screen.transpose[index]
  screen.zip(column.rotate(-amount)) { |row, new_col_value| row[index] = new_col_value }
end

screen = Array.new(HEIGHT) { [0] * WIDTH }

File.open('input/08_input.txt').each_line do |line|
  case line
  when /rect (\d+)x(\d+)/
    draw_rectangle!(screen, $1.to_i, $2.to_i)
  when /rotate row y=(\d+) by (\d+)/
    rotate_row!(screen, $1.to_i, $2.to_i)
  when /rotate column x=(\d+) by (\d+)/
    rotate_column!(screen, $1.to_i, $2.to_i)
  end
end

puts screen.flatten.count(1)

puts screen.map { |row| row.join.tr('01', ' #') }
