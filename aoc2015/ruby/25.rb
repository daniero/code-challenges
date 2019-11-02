FIRST_CODE = 20151125
MULTIPLIER = 252533
DIVIDER = 33554393

row, col = File.read('../input/25.txt').scan(/\d+/).map(&:to_i)

code =  FIRST_CODE

0.step do |v|
  (v+1).times do |w|
    x,y = w, v-w

    if x == col-1 && y == row-1
      p code
      exit
    end

    code = code * MULTIPLIER % DIVIDER
  end
end
