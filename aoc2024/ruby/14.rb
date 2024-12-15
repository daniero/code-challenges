if true
  WIDTH = 11
  HEIGHT = 7
  INPUT = '../input/14-sample.txt'
else
  WIDTH = 101
  HEIGHT = 103
  INPUT = '../input/14.txt'
end

TIME = 100


input = File
  .readlines(INPUT)
  .map { _1.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a }


result = input
  .map { |(x,y),(vx,vy)| [(x+vx*TIME)%WIDTH, (y+vy*TIME)%HEIGHT] }
  .filter { |x,y| x != WIDTH/2 && y != HEIGHT/2 }

p result
  .group_by { |x,y| [x < (WIDTH/2), y < (HEIGHT/2)] }
  .values.map(&:size)
  .reduce(:*)
